/******************************************************************************/
//
// This file was generated by OSAcfg_Tool utility.
// Do not modify it to prevent data loss on next editing.
//
//
/******************************************************************************/


#ifndef _OSACFG_H
#define _OSACFG_H

//------------------------------------------------------------------------------
// SYSTEM
//------------------------------------------------------------------------------

#define OS_TASKS       3  // Number of tasks that can be active at one time
#define OS_TIMER_SIZE  2
#define OS_TTIMER_SIZE 2


//------------------------------------------------------------------------------
// ENABLE CONSTANTS
//------------------------------------------------------------------------------

#define OS_ENABLE_TTIMERS                      // Enable task timers (allows to use OS_Delay and OS_xxx_Wait_TO)
#define OS_PRIORITY_LEVEL  OS_PRIORITY_NORMAL  // (defaul) Normal priority mode with checking tasks in order of creation 
#define OS_ENABLE_INT_SMSG                     // Allows the use of simple message services within interrupts 




//------------------------------------------------------------------------------
// BSEMS
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// STIMERS
//------------------------------------------------------------------------------



#endif
