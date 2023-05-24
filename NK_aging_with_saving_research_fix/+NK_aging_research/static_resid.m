function residual = static_resid(T, y, x, params, T_flag)
% function residual = static_resid(T, y, x, params, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%                                              to evaluate the model
%   T_flag    boolean                 boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = NK_aging_research.static_resid_tt(T, y, x, params);
end
residual = zeros(34, 1);
lhs = T(3)*T(4);
rhs = y(25);
residual(1) = lhs - rhs;
lhs = y(5)^params(3);
rhs = y(25)*y(4);
residual(2) = lhs - rhs;
lhs = y(25)*params(1)*(1+y(6)-params(9));
rhs = y(25);
residual(3) = lhs - rhs;
lhs = y(25)*params(1)*y(7)/y(8);
rhs = y(25);
residual(4) = lhs - rhs;
lhs = y(10);
rhs = y(34)*(y(4))+(y(6)-params(9))*y(29)+y(33);
residual(5) = lhs - rhs;
lhs = y(6)/y(4);
rhs = params(6)/(1-params(6))*y(12)/y(11);
residual(6) = lhs - rhs;
lhs = y(14);
rhs = T(6)*T(8);
residual(7) = lhs - rhs;
lhs = y(15);
rhs = y(25)*y(14)*y(23)+y(15)*params(1)*params(11)*T(9);
residual(8) = lhs - rhs;
lhs = y(16);
rhs = y(25)*y(23)+params(1)*params(11)*y(16)*T(10);
residual(9) = lhs - rhs;
lhs = y(17);
rhs = y(15)*y(8)*params(10)/(params(10)-1)/y(16);
residual(10) = lhs - rhs;
lhs = y(8)^(1-params(10));
rhs = params(11)+(1-params(11))*y(17)^(1-params(10));
residual(11) = lhs - rhs;
lhs = y(18);
rhs = y(1)*params(12)+y(10)*(1-params(12));
residual(12) = lhs - rhs;
lhs = y(12);
rhs = y(5)*params(12);
residual(13) = lhs - rhs;
lhs = y(11);
rhs = params(12)*y(2)+y(29)*(1-params(12));
residual(14) = lhs - rhs;
lhs = y(19);
rhs = params(12)*y(26)+y(29)*params(9)*(1-params(12));
residual(15) = lhs - rhs;
lhs = y(20);
rhs = params(12)*y(3);
residual(16) = lhs - rhs;
lhs = y(21);
rhs = params(12)*y(9);
residual(17) = lhs - rhs;
lhs = y(13);
rhs = y(13)*(1-params(9))+y(22);
residual(18) = lhs - rhs;
lhs = log(y(24));
rhs = (1-params(17))*log((y(24)))+log(y(24))*params(17)+x(1);
residual(19) = lhs - rhs;
lhs = log(y(22));
rhs = (1-params(18))*log((y(22)))+log(y(22))*params(18)+x(2);
residual(20) = lhs - rhs;
lhs = log(y(21)/(y(21)));
rhs = params(15)*log(y(20)/(y(20)));
residual(21) = lhs - rhs;
lhs = log(y(7)/(y(7)));
rhs = params(13)*log(y(8)/(y(8)))+params(14)*log(y(23)/(y(23)))+y(28);
residual(22) = lhs - rhs;
lhs = y(28);
rhs = y(28)*params(19)+x(4);
residual(23) = lhs - rhs;
lhs = y(19);
rhs = y(11)-y(11)*(1-params(9));
residual(24) = lhs - rhs;
lhs = y(23);
rhs = T(5)*T(12)*T(13);
residual(25) = lhs - rhs;
lhs = y(29);
rhs = params(26)*(y(11));
residual(26) = lhs - rhs;
lhs = y(23);
rhs = y(22)+y(24)+y(18)+y(19)+y(30);
residual(27) = lhs - rhs;
lhs = y(20)+y(21);
rhs = y(33)+y(30)+y(24)+y(22)+y(7)*y(20)/y(8)+(y(4))*y(34)*(1-params(12));
residual(28) = lhs - rhs;
lhs = y(30);
rhs = y(31)-(1-params(9))*y(31);
residual(29) = lhs - rhs;
lhs = log(y(27));
rhs = log(y(27))*params(25)+params(27)*(y(30)/y(23)-(y(30))/(y(23)))+x(3);
residual(30) = lhs - rhs;
lhs = log(y(30));
rhs = log(y(30))*params(28)+(1-params(28))*log((y(30)))+x(5);
residual(31) = lhs - rhs;
lhs = log(y(33));
rhs = log(y(33))*params(29)+(1-params(29))*log((y(33)))+x(6);
residual(32) = lhs - rhs;
lhs = y(32);
rhs = y(31)/y(23);
residual(33) = lhs - rhs;
lhs = log(y(34)*(y(4)));
rhs = log(y(34)*(y(4)))*params(30)+(1-params(30))*log((y(4))*(y(34)))+x(7);
residual(34) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
