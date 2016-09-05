/*
 * no_chattering_acc_data.c
 *
 * Code generation for model "no_chattering_acc.mdl".
 *
 * Model version              : 1.1
 * Simulink Coder version : 8.0 (R2011a) 09-Mar-2011
 * C source code generated on : Sat Apr 19 23:37:44 2014
 *
 * Target selection: accel.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: 32-bit Generic
 * Emulation hardware selection:
 *    Differs from embedded hardware (MATLAB Host)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "no_chattering_acc.h"
#include "no_chattering_acc_private.h"

/* Block parameters (auto storage) */
Parameters rtDefaultParameters = {
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Pos'
                                        */
  0.0,                                 /* Expression: 0
                                        * Referenced by: '<Root>/Vel'
                                        */
  0.1,                                 /* Expression: .1
                                        * Referenced by: '<Root>/Constant'
                                        */
  1.0E+7,                              /* Expression: k2
                                        * Referenced by: '<Root>/Gain'
                                        */
  1.0,                                 /* Expression: 1
                                        * Referenced by: '<Root>/Saturation'
                                        */
  -1.0                                 /* Expression: -1
                                        * Referenced by: '<Root>/Saturation'
                                        */
};
