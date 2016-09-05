/*
 * This file is not available for use in any application other than as a
 * MATLAB(R) MEX file for use with the Simulink(R) product.
 */

/*
 * no_chattering_acc.c
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
#include <math.h>
#include "no_chattering_acc.h"
#include "no_chattering_acc_private.h"
#include <stdio.h>
#include "simstruc.h"
#include "fixedpoint.h"
#define CodeFormat                     S-Function
#define AccDefine1                     Accelerator_S-Function

/* Outputs for root system: '<Root>' */
static void mdlOutputs(SimStruct *S, int_T tid)
{
  /* Integrator: '<Root>/Pos' */
  ((BlockIO *) _ssGetBlockIO(S))->B_1_0_0 = ((ContinuousStates *)
    ssGetContStates(S))->Pos_CSTATE;
  ssCallAccelRunBlock(S, 1, 1, SS_CALL_MDL_OUTPUTS);

  /* Integrator: '<Root>/Vel' */
  ((BlockIO *) _ssGetBlockIO(S))->B_1_2_0 = ((ContinuousStates *)
    ssGetContStates(S))->Vel_CSTATE;
  if (ssIsSampleHit(S, 1, 0)) {
    /* Level1 S-Function Block: '<S0>/B_0_0' (sfunxy) */
    /* Call into Simulink for MEX-version of S-function */
    ssCallAccelRunBlock(S, 0, 0, SS_CALL_MDL_OUTPUTS);
    ((BlockIO *) _ssGetBlockIO(S))->B_0_3_0[0] = ((BlockIO *) _ssGetBlockIO(S)
      )->B_1_0_0;
    ((BlockIO *) _ssGetBlockIO(S))->B_0_3_0[1] = ((BlockIO *) _ssGetBlockIO(S)
      )->B_1_2_0;
    ((BlockIO *) _ssGetBlockIO(S))->B_1_4_0 = ((Parameters *) ssGetDefaultParam
      (S))->P_2;
  }

  ((BlockIO *) _ssGetBlockIO(S))->B_1_6_0 = ((BlockIO *) _ssGetBlockIO(S))
    ->B_1_4_0 - ((BlockIO *) _ssGetBlockIO(S))->B_1_0_0;

  /* MATLABFcn: '<Root>/Interpreted MATLAB Function' */

  /* Call into Simulink to run the Matlab Fcn block. */
  ssCallAccelRunBlock(S, 1, 6, SS_CALL_MDL_OUTPUTS);
  ((BlockIO *) _ssGetBlockIO(S))->B_1_8_0 = (((BlockIO *) _ssGetBlockIO(S))
    ->B_1_6_0 - ((BlockIO *) _ssGetBlockIO(S))->B_1_2_0) * ((Parameters *)
    ssGetDefaultParam(S))->P_3;
  if (ssIsMajorTimeStep(S)) {
    ((D_Work *) ssGetRootDWork(S))->Saturation_MODE = ((BlockIO *) _ssGetBlockIO
      (S))->B_1_8_0 >= ((Parameters *) ssGetDefaultParam(S))->P_4 ? 1 :
      ((BlockIO *) _ssGetBlockIO(S))->B_1_8_0 > ((Parameters *)
      ssGetDefaultParam(S))->P_5 ? 0 : -1;
  }

  ((BlockIO *) _ssGetBlockIO(S))->B_1_9_0 = ((D_Work *) ssGetRootDWork(S))
    ->Saturation_MODE == 1 ? ((Parameters *) ssGetDefaultParam(S))->P_4 :
    ((D_Work *) ssGetRootDWork(S))->Saturation_MODE == -1 ? ((Parameters *)
    ssGetDefaultParam(S))->P_5 : ((BlockIO *) _ssGetBlockIO(S))->B_1_8_0;

  /* tid is required for a uniform function interface.
   * Argument tid is not used in the function. */
  UNUSED_PARAMETER(tid);
}

/* Update for root system: '<Root>' */
#define MDL_UPDATE

static void mdlUpdate(SimStruct *S, int_T tid)
{
  if (ssIsSampleHit(S, 1, 0)) {
    /* Level1 S-Function Block: '<S0>/B_0_0' (sfunxy) */
    /* Call into Simulink for MEX-version of S-function */
    ssCallAccelRunBlock(S, 0, 0, SS_CALL_MDL_UPDATE);
  }

  /* tid is required for a uniform function interface.
   * Argument tid is not used in the function. */
  UNUSED_PARAMETER(tid);
}

/* Derivatives for root system: '<Root>' */
#define MDL_DERIVATIVES

static void mdlDerivatives(SimStruct *S)
{
  /* Derivatives for Integrator: '<Root>/Pos' */
  {
    ((StateDerivatives *) ssGetdX(S))->Pos_CSTATE = ((BlockIO *) _ssGetBlockIO(S))
      ->B_1_2_0;
  }

  /* Derivatives for Integrator: '<Root>/Vel' */
  {
    ((StateDerivatives *) ssGetdX(S))->Vel_CSTATE = ((BlockIO *) _ssGetBlockIO(S))
      ->B_1_9_0;
  }
}

/* ZeroCrossings for root system: '<Root>' */
#define MDL_ZERO_CROSSINGS

static void mdlZeroCrossings(SimStruct *S)
{
  ((ZCSignalValues *) ssGetSolverZcSignalVector(S))->Saturation_UprLim_ZC =
    ((BlockIO *) _ssGetBlockIO(S))->B_1_8_0 - ((Parameters *) ssGetDefaultParam
    (S))->P_4;
  ((ZCSignalValues *) ssGetSolverZcSignalVector(S))->Saturation_LwrLim_ZC =
    ((BlockIO *) _ssGetBlockIO(S))->B_1_8_0 - ((Parameters *) ssGetDefaultParam
    (S))->P_5;
}

/* Function to initialize sizes */
static void mdlInitializeSizes(SimStruct *S)
{
  /* checksum */
  ssSetChecksumVal(S, 0, 4032246934U);
  ssSetChecksumVal(S, 1, 3571075540U);
  ssSetChecksumVal(S, 2, 2545423485U);
  ssSetChecksumVal(S, 3, 1751738957U);

  /* options */
  ssSetOptions(S, SS_OPTION_EXCEPTION_FREE_CODE);

  /* Accelerator check memory map size match for DWork */
  if (ssGetSizeofDWork(S) != sizeof(D_Work)) {
    ssSetErrorStatus(S,"Unexpected error: Internal DWork sizes do "
                     "not match for accelerator mex file.");
  }

  /* Accelerator check memory map size match for BlockIO */
  if (ssGetSizeofGlobalBlockIO(S) != sizeof(BlockIO)) {
    ssSetErrorStatus(S,"Unexpected error: Internal BlockIO sizes do "
                     "not match for accelerator mex file.");
  }

  /* model parameters */
  _ssSetDefaultParam(S, (real_T *) &rtDefaultParameters);

  /* non-finites */
  rt_InitInfAndNaN(sizeof(real_T));
}

/* mdlInitializeSampleTimes function (used to set up function-call connections) */
static void mdlInitializeSampleTimes(SimStruct *S)
{
}

/* Empty mdlTerminate function (never called) */
static void mdlTerminate(SimStruct *S)
{
}

/* MATLAB MEX Glue */
#include "simulink.c"
