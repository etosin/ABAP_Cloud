class ZSOA_CX_FAULT_MSG_TYPE definition
  public
  inheriting from CX_AI_APPLICATION_FAULT
  create public .

public section.

  data AUTOMATIC_RETRY type PRX_AUTOMATIC_RETRY read-only .
  data CONTROLLER type PRXCTRLTAB read-only .
  data ERROR_TEXT type STRING read-only .
  data NO_RETRY type PRX_NO_RETRY read-only .
  data WF_TRIGGERED type PRX_WORKFLOW_TRIGGERED read-only .

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      !AUTOMATIC_RETRY type PRX_AUTOMATIC_RETRY optional
      !CONTROLLER type PRXCTRLTAB optional
      !ERROR_TEXT type STRING optional
      !NO_RETRY type PRX_NO_RETRY optional
      !WF_TRIGGERED type PRX_WORKFLOW_TRIGGERED optional .
protected section.
private section.
ENDCLASS.



CLASS ZSOA_CX_FAULT_MSG_TYPE IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
TEXTID = TEXTID
PREVIOUS = PREVIOUS
.
me->AUTOMATIC_RETRY = AUTOMATIC_RETRY .
me->CONTROLLER = CONTROLLER .
me->ERROR_TEXT = ERROR_TEXT .
me->NO_RETRY = NO_RETRY .
me->WF_TRIGGERED = WF_TRIGGERED .
  endmethod.
ENDCLASS.
