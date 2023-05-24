function T = static_resid_tt(T, y, x, params)
% function T = static_resid_tt(T, y, x, params)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%
% Output:
%   T         [#temp variables by 1]  double   vector of temporary terms
%

assert(length(T) >= 13);

T(1) = (params(5)-1)/params(5);
T(2) = params(4)*y(1)^T(1)+(1-params(4))*y(24)^T(1);
T(3) = params(4)*T(2)^(-1);
T(4) = y(1)^((-1)/params(5));
T(5) = y(13)^params(7);
T(6) = y(4)/(1-params(6))/T(5);
T(7) = y(6)*(1-params(6))/params(6)/y(4);
T(8) = T(7)^params(6);
T(9) = y(8)^params(10);
T(10) = y(8)^(params(10)-1);
T(11) = y(11)^params(6);
T(12) = y(27)*T(11);
T(13) = y(12)^(1-params(6));

end
