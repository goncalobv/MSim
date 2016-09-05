/*
 * no_chattering_acc.h
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
#ifndef RTW_HEADER_no_chattering_acc_h_
#define RTW_HEADER_no_chattering_acc_h_
#ifndef no_chattering_acc_COMMON_INCLUDES_
# define no_chattering_acc_COMMON_INCLUDES_
#include <stdlib.h>
#include <stddef.h>
#define S_FUNCTION_NAME                simulink_only_sfcn
#define S_FUNCTION_LEVEL               2
#define RTW_GENERATED_S_FUNCTION
#include "rtwtypes.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "rt_nonfinite.h"
#endif                                 /* no_chattering_acc_COMMON_INCLUDES_ */

#include "no_chattering_acc_types.h"

/* Block signals (auto storage) */
typedef struct {
  real_T B_1_0_0;                      /* '<Root>/Pos' */
  real_T B_1_2_0;                      /* '<Root>/Vel' */
  real_T B_1_4_0;                      /* '<Root>/Constant' */
  real_T B_1_8_0;                      /* '<Root>/Gain' */
  real_T B_1_9_0;                      /* '<Root>/Saturation' */
  real_T B_0_3_0[2];
  real_T B_1_6_0;                      /* '<Root>/Interpreted MATLAB Function' */
} BlockIO;

/* Block states (auto storage) for system '<Root>' */
typedef struct {
  int_T Saturation_MODE;               /* '<Root>/Saturation' */
  char pad_Saturation_MODE[4];
} D_Work;

/* Continuous states (auto storage) */
typedef struct {
  real_T Pos_CSTATE;                   /* '<Root>/Pos' */
  real_T Vel_CSTATE;                   /* '<Root>/Vel' */
} ContinuousStates;

/* State derivatives (auto storage) */
typedef struct {
  real_T Pos_CSTATE;                   /* '<Root>/Pos' */
  real_T Vel_CSTATE;                   /* '<Root>/Vel' */
} StateDerivatives;

/* State disabled  */
typedef struct {
  boolean_T Pos_CSTATE;                /* '<Root>/Pos' */
  boolean_T Vel_CSTATE;                /* '<Root>/Vel' */
} StateDisabled;

/* Zero-crossing (trigger) state */
typedef struct {
  real_T Saturation_UprLim_ZC;         /* '<Root>/Saturation' */
  real_T Saturation_LwrLim_ZC;         /* '<Root>/Saturation' */
} ZCSignalValues;

/* Zero-crossing (trigger) state */
typedef struct {
  ZCSigState Saturation_UprLim_ZCE;    /* '<Root>/Saturation' */
  ZCSigState Saturation_LwrLim_ZCE;    /* '<Root>/Saturation' */
} PrevZCSigStates;

/* External outputs (root outports fed by signals with auto storage) */
typedef struct {
  real_T *B_1_1;                       /* '<Root>/B_1_1' */
} ExternalOutputs;

/* Parameters (auto storage) */
struct Parameters_ {
  real_T P_0;                          /* Expression: 0
                                        * Referenced by: '<Root>/Pos'
                                        */
  real_T P_1;                          /* Expression: 0
                                        * Referenced by: '<Root>/Vel'
                                        */
  real_T P_2;                          /* Expression: .1
                                        * Referenced by: '<Root>/Constant'
                                        */
  real_T P_3;                          /* Expression: k2
                                        * Referenced by: '<Root>/Gain'
                                        */
  real_T P_4;                          /* Expression: 1
                                        * Referenced by: '<Root>/Saturation'
                                        */
  real_T P_5;                          /* Expression: -1
                                        * Referenced by: '<Root>/Saturation'
                                        */
};

extern Parameters rtDefaultParameters; /* parameters */

#endif                                 /* RTW_HEADER_no_chattering_acc_h_ */
