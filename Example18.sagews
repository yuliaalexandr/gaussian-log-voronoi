︠db8e96b0-a4db-4ee4-910c-d20598af18a4s︠
vars=var('s11,s12,s13,s14,s22,s23,s24,s33,s34,s44,a1,a2,a3,a4,b12,b24,b34')
def likelihood (Sigma, S0):
    return -log(Sigma.det())-(S0*(Sigma.inverse())).trace()

def makeMatrix(a1,a2,a3,a4,b12,b24,b34):
    return matrix([[a1,a1*b12,0,a1*b12*b24],[a1*b12,a2,0,a2*b24],[0,0,a3,a3*b34],[a1*b12*b24,a2*b24,a3*b34,a4]])

def makeMatrix2 (g11,g12,g13,g14,g22,g23,g24,g33,g34,g44):
    return matrix([[g11,g12,g13,g14],[g12,g22,g23,g24],[g13,g23,g33,g34],[g14,g24,g34,g44]])

︡64ba0049-2359-4a90-88ce-c0a15404cceb︡{"done":true}
︠2e8680f3-e91b-45bc-bf5d-4c0d88cdd9d7s︠
M=makeMatrix(a1,a2,a3,a4,b12,b24,b34)
S=matrix([[s11,s12,s13,s14],[s12,s22,s23,s24],[s13,s23,s33,s34],[s14,s24,s34,s44]])
l=likelihood(M,S).full_simplify()

︡297de9fd-d993-4f79-bdb9-7b67618d2b08︡{"done":true}
︠28d63c3e-44f1-41e9-be1f-4df917ef256ds︠
l1=l.derivative(a1).full_simplify()
l2=l.derivative(a2).full_simplify()
l3=l.derivative(a3).full_simplify()
l4=l.derivative(a4).full_simplify()
l5=l.derivative(b12).full_simplify()
l6=l.derivative(b24).full_simplify()
l7=l.derivative(b34).full_simplify()
︡0569d10a-b796-4a6c-83d8-3a0449f874e7︡{"done":true}
︠c2cf31e5-fb7b-4ab8-bab7-da88c19f84f9s︠
silly=maxima_calculus.reset()
sol=solve([l1==0,l2==0,l3==0,l4==0,l5==0,l6==0,l7==0],s11,s12,s13,s14,s22,s23,s24,s33,s34,s44)[0]

sol
︡fea582c5-9563-41af-be88-5264829240b8︡{"stdout":"[s11 == a1, s12 == a1*b12, s13 == r1, s14 == r2, s22 == a2, s23 == r3, s24 == a2*b24 + b34*r3, s33 == a3, s34 == a3*b34 + b24*r3, s44 == 2*b24*b34*r3 + a4]\n"}︡{"done":true}
︠ef7828f9-9259-480b-9bae-e010450da3b6s︠
T=makeMatrix2(sol[0].rhs(),sol[1].rhs(),sol[2].rhs(),sol[3].rhs(),sol[4].rhs(),sol[5].rhs(),sol[6].rhs(),sol[7].rhs(),sol[8].rhs(),sol[9].rhs())

var('x,y,z')
P=T.subs(r1=x,r2=y,r3=z)
P
︡98d54c34-3cde-4051-bef8-b397571d26fb︡{"stdout":"(x, y, z)\n"}︡{"stdout":"[              a1           a1*b12                x                y]\n[          a1*b12               a2                z   a2*b24 + b34*z]\n[               x                z               a3   a3*b34 + b24*z]\n[               y   a2*b24 + b34*z   a3*b34 + b24*z 2*b24*b34*z + a4]\n"}︡{"done":true}
︠231df421-7b24-44e5-a526-377b9c81b77cs︠
N=M.subs(a1=1,a2=2,a3=3,a4=4,b12=1/2,b24=1,b34=1/2)
M.subs(a1=1,a2=2,a3=3,a4=4,b12=1/2,b24=1,b34=1/2).is_positive_definite()
︡2a77dd8d-ac6d-4a0f-a3b9-faf15d7c5900︡{"stdout":"True\n"}︡{"done":true}
︠156bcc95-77a1-4ed9-bfad-c147049a47cbs︠
M
︡5a1fb278-53eb-4a2b-b187-703813f57aa4︡{"stdout":"[        a1     a1*b12          0 a1*b12*b24]\n[    a1*b12         a2          0     a2*b24]\n[         0          0         a3     a3*b34]\n[a1*b12*b24     a2*b24     a3*b34         a4]\n"}︡{"done":true}
︠545abe8a-f3f8-4d9b-a8b0-a4934edb17ads︠
N
N.is_positive_definite()
︡c6c50a9f-ee23-4a4a-a97b-f5ae0a43c7e1︡{"stdout":"[  1 1/2   0 1/2]\n[1/2   2   0   2]\n[  0   0   3 3/2]\n[1/2   2 3/2   4]\n"}︡{"stdout":"True\n"}︡{"done":true}
︠77a8b3ed-6c88-45e2-ae0c-204614c788a0s︠
U=T.subs(a1=1,a2=2,a3=3,a4=4,b12=1/2,b24=1,b34=1/2)
U[[0,1,2],[0,1,2]].det().subs(r1=x,r2=y,r3=z)
U.det().subs(r1=x,r2=y,r3=z)
︡9aa967db-dec2-4802-9661-db4e7628c365︡{"stdout":"-1/2*(4*x - z)*x + 1/2*x*z - z^2 + 21/4\n"}︡{"stdout":"1/4*x^2*z^2 - x*y*z^2 + y^2*z^2 + 1/2*x*z^2 - y*z^2 - 4*x^2 + 6*x*y - 6*y^2 + 5/4*x*z - z^2 - 3*x + 6*y + 81/16\n"}︡{"done":true}
︠02355744-9ee0-4dbf-8c2d-c72f835903d5︠









