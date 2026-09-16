REPORT z_employee_payroll_report.

*---------------------------------------------------------------------*
* Employee Payroll Management System
* Demonstrates:
* - Selection screen
* - Open SQL
* - Structures / work areas
* - Internal tables
* - Payroll calculations
* - ALV reporting
*---------------------------------------------------------------------*

TABLES zemp_payroll.

TYPES: BEGIN OF ty_payroll,
         emp_id        TYPE zemp_payroll-emp_id,
         emp_name      TYPE zemp_payroll-emp_name,
         department    TYPE zemp_payroll-department,
         basic_salary  TYPE zemp_payroll-basic_salary,
         hra           TYPE zemp_payroll-hra,
         bonus         TYPE zemp_payroll-bonus,
         gross_salary  TYPE p LENGTH 13 DECIMALS 2,
         deduction     TYPE zemp_payroll-deduction,
         net_salary    TYPE p LENGTH 13 DECIMALS 2,
       END OF ty_payroll.

DATA: gt_payroll TYPE STANDARD TABLE OF ty_payroll,
      gs_payroll TYPE ty_payroll.

DATA: gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_fieldcat TYPE slis_fieldcat_alv.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
SELECT-OPTIONS s_empid FOR zemp_payroll-emp_id.
SELECTION-SCREEN END OF BLOCK b1.

INITIALIZATION.
  text-001 = 'Employee Selection'.

START-OF-SELECTION.
  PERFORM get_employee_data.
  PERFORM calculate_payroll.
  PERFORM build_field_catalog.
  PERFORM display_report.

*---------------------------------------------------------------------*
* Read employee data using Open SQL
*---------------------------------------------------------------------*
FORM get_employee_data.

  SELECT emp_id
         emp_name
         department
         basic_salary
         hra
         bonus
         deduction
    FROM zemp_payroll
    INTO CORRESPONDING FIELDS OF TABLE gt_payroll
    WHERE emp_id IN s_empid.

  IF sy-subrc <> 0.
    MESSAGE 'No employee records found.' TYPE 'I'.
    LEAVE LIST-PROCESSING.
  ENDIF.

ENDFORM.

*---------------------------------------------------------------------*
* Calculate gross and net salary
*---------------------------------------------------------------------*
FORM calculate_payroll.

  LOOP AT gt_payroll INTO gs_payroll.

    gs_payroll-gross_salary =
      gs_payroll-basic_salary
      + gs_payroll-hra
      + gs_payroll-bonus.

    gs_payroll-net_salary =
      gs_payroll-gross_salary
      - gs_payroll-deduction.

    MODIFY gt_payroll FROM gs_payroll.

  ENDLOOP.

ENDFORM.

*---------------------------------------------------------------------*
* Build ALV field catalog
*---------------------------------------------------------------------*
FORM build_field_catalog.

  PERFORM add_field USING 'EMP_ID'       'Employee ID'.
  PERFORM add_field USING 'EMP_NAME'     'Employee Name'.
  PERFORM add_field USING 'DEPARTMENT'   'Department'.
  PERFORM add_field USING 'BASIC_SALARY' 'Basic Salary'.
  PERFORM add_field USING 'HRA'          'HRA'.
  PERFORM add_field USING 'BONUS'        'Bonus'.
  PERFORM add_field USING 'GROSS_SALARY' 'Gross Salary'.
  PERFORM add_field USING 'DEDUCTION'    'Deduction'.
  PERFORM add_field USING 'NET_SALARY'   'Net Salary'.

ENDFORM.

FORM add_field USING p_field TYPE slis_fieldname
                     p_text  TYPE char40.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = p_field.
  gs_fieldcat-seltext_m = p_text.
  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.

*---------------------------------------------------------------------*
* Display payroll report
*---------------------------------------------------------------------*
FORM display_report.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      it_fieldcat        = gt_fieldcat
    TABLES
      t_outtab           = gt_payroll
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc <> 0.
    MESSAGE 'Unable to display ALV report.' TYPE 'E'.
  ENDIF.

ENDFORM.
