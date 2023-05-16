︠8cd9cf17-f853-4b58-ad38-c72bc99fb363s︠
#c>0 case:

vars=var('a,b,c,k')

def discrim(b,a):
    return -4*(b^4-(a^2+8*a-11)*b^2+(2*a-1)^3)

f(x)=x^3-b*x^2-x*(1-2*a)-b
def likelihood (Sigma, S0):
    return -log(det(Sigma))-(S0*(Sigma.inverse())).trace()

vars=var('a0,b0,c')

a0=f(x).subs({x:c}).solve(a)[0].subs({b:b0}).right(); a0

def makeMatrix(v,w):
    return Matrix([[k, w],[w, 2*a0-k]]);

T=makeMatrix(a0,b0)

print('A matrix in a log-Voronoi cell of c is of the form:'); T;
#T.is_positive_definite()

print()
print('The roots are:')

g(x)=f(x).subs({a:a0, b:b0})
for i in [0,1,2]:
    g.roots(x)[i][0]
︡da38b3f9-9ffb-48ac-aff7-778cb228e86a︡{"stdout":"1/2*(b0*c^2 - c^3 + b0 + c)/c\n"}︡{"stdout":"A matrix in a log-Voronoi cell of c is of the form:\n[                             k                             b0]\n[                            b0 -k + (b0*c^2 - c^3 + b0 + c)/c]\n"}︡{"stdout":"\n"}︡{"stdout":"The roots are:\n"}︡{"stdout":"1/2*(b0*c - c^2 - sqrt(b0^2*c^2 - 2*b0*c^3 + c^4 - 4*b0*c))/c\n1/2*(b0*c - c^2 + sqrt(b0^2*c^2 - 2*b0*c^3 + c^4 - 4*b0*c))/c\nc\n"}︡{"done":true}
︠e7d415ae-f911-4882-8db2-e3407ef57dd6s︠
#non-positive discriminant case:
cd_discrim=discrim(b,a).subs({a:a0,b:b0}).full_simplify(); cd_discrim
cd_discrim.numerator().factor() #the second factor is squared, so always non-negative
(b0^2*c - 2*b0*c^2 + c^3 - 4*b0).roots(b0)
︡fb24e374-878f-4c7c-afaf-55c8780ef4dd︡{"stdout":"(13*b0^2*c^7 - 12*b0*c^8 + 4*c^9 + 4*b0^3*c^4 - 6*(b0^3 + 2*b0)*c^6 + (b0^4 + 6*b0^2)*c^5 + b0^4*c + 6*b0^3*c^2 - (2*b0^4 + 15*b0^2)*c^3 - 4*b0^3)/c^3\n"}︡{"stdout":"(b0^2*c - 2*b0*c^2 + c^3 - 4*b0)*(b0*c^2 - 2*c^3 - b0)^2\n"}︡{"stdout":"[((c^2 - 2*sqrt(c^2 + 1) + 2)/c, 1), ((c^2 + 2*sqrt(c^2 + 1) + 2)/c, 1)]\n"}︡{"done":true}
︠baa6dbd4-162e-4b49-ad5f-cbd4253528a5s︠
l=(c^2-2*sqrt(c^2+1)+2)/c; #left boundary coming from disc<0
r=(c^2+2*sqrt(c^2+1)+2)/c; #right boundary coming from disc<0
m=c^3/(c^2+1) #boundary coming from a<1/2

m>r
solve([m<r],c) #always true since c>0 by assumption
︡11ebe3fc-db2e-4bca-b5f8-70099c6e0cf6︡{"stdout":"c^3/(c^2 + 1) > (c^2 + 2*sqrt(c^2 + 1) + 2)/c\n"}︡{"stdout":"[[0 < c]]\n"}︡{"done":true}
︠7ebdd0e2-15e1-423b-941d-63a86bd30a28s︠

#create covariance matrices for all critical points
critical=[]
def M(x):
    return Matrix([[1,x],[x,1]])

for i in [0,1,2]:
     critical.append(M((g.roots(x)[i][0])))
show(critical)
︡8427fce0-60a9-47e3-991b-0e6ca2499546︡{"html":"<div align='center'>[$\\displaystyle \\left(\\begin{array}{rr}\n1 &amp; \\frac{b_{0} c - c^{2} - \\sqrt{b_{0}^{2} c^{2} - 2 \\, b_{0} c^{3} + c^{4} - 4 \\, b_{0} c}}{2 \\, c} \\\\\n\\frac{b_{0} c - c^{2} - \\sqrt{b_{0}^{2} c^{2} - 2 \\, b_{0} c^{3} + c^{4} - 4 \\, b_{0} c}}{2 \\, c} &amp; 1\n\\end{array}\\right)$, $\\displaystyle \\left(\\begin{array}{rr}\n1 &amp; \\frac{b_{0} c - c^{2} + \\sqrt{b_{0}^{2} c^{2} - 2 \\, b_{0} c^{3} + c^{4} - 4 \\, b_{0} c}}{2 \\, c} \\\\\n\\frac{b_{0} c - c^{2} + \\sqrt{b_{0}^{2} c^{2} - 2 \\, b_{0} c^{3} + c^{4} - 4 \\, b_{0} c}}{2 \\, c} &amp; 1\n\\end{array}\\right)$, $\\displaystyle \\left(\\begin{array}{rr}\n1 &amp; c \\\\\nc &amp; 1\n\\end{array}\\right)$]</div>"}︡{"done":true}
︠c7761ab8-ce20-4951-b138-5be17ff2794ds︠
#the values of log-likelihood function
values=[]
for i in [0,1,2]:
    values.append((likelihood(critical[i], T).numerator()/likelihood(critical[i], T).denominator()).full_simplify())
    show(values[i])
    print()
print()
︡3e38e5d0-c244-4086-abb5-1320414c9d23︡{"html":"<div align='center'>$\\displaystyle -\\frac{4 \\, b_{0} c^{2} - 2 \\, c^{3} - 2 \\, {\\left(b_{0}^{2} - 1\\right)} c + {\\left(2 \\, b_{0} c^{2} - c^{3} - {\\left(b_{0}^{2} - 2\\right)} c + 2 \\, b_{0}\\right)} \\log\\left(\\frac{2 \\, b_{0} c^{2} - c^{3} - {\\left(b_{0}^{2} - 2\\right)} c + \\sqrt{b_{0}^{2} c^{2} - 2 \\, b_{0} c^{3} + c^{4} - 4 \\, b_{0} c} {\\left(b_{0} - c\\right)} + 2 \\, b_{0}}{2 \\, c}\\right) + \\sqrt{b_{0}^{2} c^{2} - 2 \\, b_{0} c^{3} + c^{4} - 4 \\, b_{0} c} {\\left({\\left(b_{0} - c\\right)} \\log\\left(\\frac{2 \\, b_{0} c^{2} - c^{3} - {\\left(b_{0}^{2} - 2\\right)} c + \\sqrt{b_{0}^{2} c^{2} - 2 \\, b_{0} c^{3} + c^{4} - 4 \\, b_{0} c} {\\left(b_{0} - c\\right)} + 2 \\, b_{0}}{2 \\, c}\\right) + 2 \\, b_{0}\\right)} + 2 \\, b_{0}}{2 \\, b_{0} c^{2} - c^{3} - {\\left(b_{0}^{2} - 2\\right)} c + \\sqrt{b_{0}^{2} c^{2} - 2 \\, b_{0} c^{3} + c^{4} - 4 \\, b_{0} c} {\\left(b_{0} - c\\right)} + 2 \\, b_{0}}$</div>"}︡{"stdout":"\n"}︡{"html":"<div align='center'>$\\displaystyle -\\frac{4 \\, b_{0} c^{2} - 2 \\, c^{3} - 2 \\, {\\left(b_{0}^{2} - 1\\right)} c + {\\left(2 \\, b_{0} c^{2} - c^{3} - {\\left(b_{0}^{2} - 2\\right)} c + 2 \\, b_{0}\\right)} \\log\\left(\\frac{2 \\, b_{0} c^{2} - c^{3} - {\\left(b_{0}^{2} - 2\\right)} c - \\sqrt{b_{0}^{2} c^{2} - 2 \\, b_{0} c^{3} + c^{4} - 4 \\, b_{0} c} {\\left(b_{0} - c\\right)} + 2 \\, b_{0}}{2 \\, c}\\right) - \\sqrt{b_{0}^{2} c^{2} - 2 \\, b_{0} c^{3} + c^{4} - 4 \\, b_{0} c} {\\left({\\left(b_{0} - c\\right)} \\log\\left(\\frac{2 \\, b_{0} c^{2} - c^{3} - {\\left(b_{0}^{2} - 2\\right)} c - \\sqrt{b_{0}^{2} c^{2} - 2 \\, b_{0} c^{3} + c^{4} - 4 \\, b_{0} c} {\\left(b_{0} - c\\right)} + 2 \\, b_{0}}{2 \\, c}\\right) + 2 \\, b_{0}\\right)} + 2 \\, b_{0}}{2 \\, b_{0} c^{2} - c^{3} - {\\left(b_{0}^{2} - 2\\right)} c - \\sqrt{b_{0}^{2} c^{2} - 2 \\, b_{0} c^{3} + c^{4} - 4 \\, b_{0} c} {\\left(b_{0} - c\\right)} + 2 \\, b_{0}}$</div>"}︡{"stdout":"\n"}︡{"html":"<div align='center'>$\\displaystyle -\\frac{c \\log\\left(-c^{2} + 1\\right) + b_{0} + c}{c}$</div>"}︡{"stdout":"\n"}︡{"stdout":"\n"}︡{"done":true}
︠f20b067d-6396-4785-9b6b-8f7dde4fe26as︠







#c=0 case
f(x).subs(b=0)
solve(f(x).subs(b=0)==0,x)
︡baf8b85c-2626-44ab-ba45-8c9e6c9b25fa︡{"stdout":"x^3 + (2*a - 1)*x\n"}︡{"stdout":"[x == -sqrt(-2*a + 1), x == sqrt(-2*a + 1), x == 0]\n"}︡{"done":true}
︠3f098922-7e99-457a-aef5-cb5174ec5a6ds︠

#get values of the log-likelihood function at these points whenever c<=1/2
c1=-sqrt(-2*a + 1)
c2=sqrt(-2*a + 1)
c=0

T=matrix([[k,0],[0,2*a-k]])

critical=[M(c1),M(c2),M(c)]

values=[]
for i in [0,1,2]:
    values.append(likelihood(critical[i], T).full_simplify())
    values[i].full_simplify()
print()
︡ab0a4fa6-a01a-4690-8105-13a4f7b10df0︡{"stdout":"-log(2*a) - 1\n-log(2*a) - 1"}︡{"stdout":"\n-2*a\n"}︡{"stdout":"\n"}︡{"done":true}
︠f075f694-8317-4d65-a8b5-fda580821cd9s︠
#plot these two functions:
plt=Graphics()
plt+=plot(values[0],(a,0,2), color='blue')
plt+=plot(values[2],(a,0,2), color='cyan')

plt
︡e83c8173-3df7-4448-8716-2035fd6b3be7︡{"file":{"filename":"/tmp/tmpyr7got_e/tmp_j6sf32vj.svg","show":true,"text":null,"uuid":"0bf9dd1b-e6b5-4a53-80a2-0cd430db2c80"},"once":false}︡{"done":true}









