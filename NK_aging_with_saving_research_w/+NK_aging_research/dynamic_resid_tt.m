function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double  vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double  vector of endogenous variables in the order stored
%                                                    in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double  matrix of exogenous variables (in declaration order)
%                                                    for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double  vector of steady state values
%   params        [M_.param_nbr by 1]        double  vector of parameter values in declaration order
%   it_           scalar                     double  time period for exogenous variables for which
%                                                    to evaluate the model
%
% Output:
%   T           [#temp variables by 1]       double  vector of temporary terms
%

assert(length(T) >= 13);

T(1) = (params(5)-1)/params(5);
T(2) = params(4)*y(13)^T(1)+(1-params(4))*y(36)^T(1);
T(3) = params(4)*T(2)^(-1);
T(4) = y(13)^((-1)/params(5));
T(5) = y(25)^params(7);
T(6) = y(16)/(1-params(6))/T(5);
T(7) = y(18)*(1-params(6))/params(6)/y(16);
T(8) = T(7)^params(6);
T(9) = y(48)^params(10);
T(10) = y(48)^(params(10)-1);
T(11) = y(23)^params(6);
T(12) = y(39)*T(11);
T(13) = y(24)^(1-params(6));

end
