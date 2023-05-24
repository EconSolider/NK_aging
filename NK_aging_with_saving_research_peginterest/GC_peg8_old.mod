
@#define peg=8
@#include "3model.inc"

shocks;
var epsgc=(0.01/GC_Y)^2;
var epsTR=(0.01/TR_Y)^2;
var epsINI=(0.01/INI_Y)^2;
var epsa=0.01^2;
end;
stoch_simul(order=1,irf=10,periods=0,nograph,noprint);
