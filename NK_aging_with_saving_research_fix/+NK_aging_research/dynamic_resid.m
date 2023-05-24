function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
% function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = NK_aging_research.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(34, 1);
lhs = T(3)*T(4);
rhs = y(37);
residual(1) = lhs - rhs;
lhs = y(17)^params(3);
rhs = y(37)*y(16);
residual(2) = lhs - rhs;
lhs = params(1)*y(51)*(1+y(47)-params(9));
rhs = y(37);
residual(3) = lhs - rhs;
lhs = params(1)*y(51)*y(19)/y(48);
rhs = y(37);
residual(4) = lhs - rhs;
lhs = y(22);
rhs = y(46)*(steady_state(4))+(y(18)-params(9))*y(41)+y(45);
residual(5) = lhs - rhs;
lhs = y(18)/y(16);
rhs = params(6)/(1-params(6))*y(24)/y(23);
residual(6) = lhs - rhs;
lhs = y(26);
rhs = T(6)*T(8);
residual(7) = lhs - rhs;
lhs = y(27);
rhs = y(37)*y(26)*y(35)+params(1)*params(11)*y(49)*T(9);
residual(8) = lhs - rhs;
lhs = y(28);
rhs = y(37)*y(35)+params(1)*params(11)*y(50)*T(10);
residual(9) = lhs - rhs;
lhs = y(29);
rhs = y(27)*params(10)/(params(10)-1)*y(20)/y(28);
residual(10) = lhs - rhs;
lhs = y(20)^(1-params(10));
rhs = params(11)+(1-params(11))*y(29)^(1-params(10));
residual(11) = lhs - rhs;
lhs = y(30);
rhs = y(13)*params(12)+y(22)*(1-params(12));
residual(12) = lhs - rhs;
lhs = y(24);
rhs = y(17)*params(12);
residual(13) = lhs - rhs;
lhs = y(23);
rhs = params(12)*y(14)+y(41)*(1-params(12));
residual(14) = lhs - rhs;
lhs = y(31);
rhs = params(12)*y(38)+y(41)*params(9)*(1-params(12));
residual(15) = lhs - rhs;
lhs = y(32);
rhs = params(12)*y(15);
residual(16) = lhs - rhs;
lhs = y(33);
rhs = params(12)*y(21);
residual(17) = lhs - rhs;
lhs = y(25);
rhs = (1-params(9))*y(3)+y(34);
residual(18) = lhs - rhs;
lhs = log(y(36));
rhs = (1-params(17))*log((steady_state(24)))+params(17)*log(y(6))+x(it_, 1);
residual(19) = lhs - rhs;
lhs = log(y(34));
rhs = (1-params(18))*log((steady_state(22)))+params(18)*log(y(5))+x(it_, 2);
residual(20) = lhs - rhs;
lhs = log(y(33)/(steady_state(21)));
rhs = params(15)*log(y(32)/(steady_state(20)));
residual(21) = lhs - rhs;
lhs = log(y(19)/(steady_state(7)));
rhs = params(13)*log(y(20)/(steady_state(8)))+params(14)*log(y(35)/(steady_state(23)))+y(40);
residual(22) = lhs - rhs;
lhs = y(40);
rhs = params(19)*y(8)+x(it_, 4);
residual(23) = lhs - rhs;
lhs = y(31);
rhs = y(23)-(1-params(9))*y(2);
residual(24) = lhs - rhs;
lhs = y(35);
rhs = T(5)*T(12)*T(13);
residual(25) = lhs - rhs;
lhs = y(41);
rhs = params(26)*(steady_state(11));
residual(26) = lhs - rhs;
lhs = y(35);
rhs = y(34)+y(36)+y(30)+y(31)+y(42);
residual(27) = lhs - rhs;
lhs = y(32)+y(33);
rhs = y(45)+y(42)+y(36)+y(34)+y(1)*y(4)/y(20)+(steady_state(4))*y(46)*(1-params(12));
residual(28) = lhs - rhs;
lhs = y(42);
rhs = y(43)-(1-params(9))*y(10);
residual(29) = lhs - rhs;
lhs = log(y(39));
rhs = params(25)*log(y(7))+params(27)*(y(42)/y(35)-(steady_state(30))/(steady_state(23)))+x(it_, 3);
residual(30) = lhs - rhs;
lhs = log(y(42));
rhs = params(28)*log(y(9))+(1-params(28))*log((steady_state(30)))+x(it_, 5);
residual(31) = lhs - rhs;
lhs = log(y(45));
rhs = params(29)*log(y(11))+(1-params(29))*log((steady_state(33)))+x(it_, 6);
residual(32) = lhs - rhs;
lhs = y(44);
rhs = y(43)/y(35);
residual(33) = lhs - rhs;
lhs = log(y(46)*(steady_state(4)));
rhs = params(30)*log((steady_state(4))*y(12))+(1-params(30))*log((steady_state(4))*(steady_state(34)))+x(it_, 7);
residual(34) = lhs - rhs;

end
