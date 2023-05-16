︠d32ae499-2237-4a4e-b8c1-2dd7b5526ad6s︠
vars=var('x,y,z,t')
def likelihood (Sigma, S0):
    return -log(det(Sigma))-(S0*(Sigma.inverse())).trace() 

def makeMatrix(x,y,z):
    return Matrix([[1,x,z],[x,1,y],[z,y,1]])

def S(t):
    return Matrix(([t,0,0],[0,t,0],[0,0,t]))

def alpha(t):
    return (t-1+sqrt(t^2-18*t+9))/4

def beta(t):
    return (t-1-sqrt(t^2-18*t+9))/4

f=likelihood(makeMatrix(x,y,z),S(1/4)).full_simplify()

makeMatrix(x,y,z)
︡41337fa5-b640-4c41-8650-d8d6b042dec0︡{"stdout":"[1 x z]\n[x 1 y]\n[z y 1]\n"}︡{"done":true}
︠27d38927-e0e6-4c68-a670-fc3bcb7c6417s︠
vars=var('s11,s12,s13,s22,s23,s33')
S=matrix([[s11,s12,s13],[s12,s22,s23],[s13,s23,s33]]) #generic matrix
l=likelihood(makeMatrix(x,y,z),S)
lx=l.derivative(x).full_simplify()
ly=l.derivative(y).full_simplify()
lz=l.derivative(z).full_simplify()

silly=maxima_calculus.reset()
sol=solve([lx==0,ly==0,lz==0],s11,s12,s13,s22,s23,s33)[0]

T=S.subs(s11=sol[0].rhs(),s12=sol[1].rhs(),s13=sol[2].rhs(),s22=sol[3].rhs(),s23=sol[4].rhs(),s33=sol[5].rhs())
show(T)
︡1a5369f6-60e5-4818-8150-3d1cce41c7fe︡{"html":"<div align='center'>$\\displaystyle \\left(\\begin{array}{rrr}\n\\frac{y z^{5} - {\\left(2 \\, x y^{2} - {\\left(r_{2} x - r_{3}\\right)} y\\right)} z^{4} + r_{1} x y^{2} - r_{3} y^{3} - {\\left(r_{2} x^{2} - {\\left(r_{3} x - r_{2}\\right)} y^{2} - y^{3} + {\\left({\\left(r_{1} - 1\\right)} x^{2} - r_{1} + 2\\right)} y\\right)} z^{3} + {\\left(r_{1} x^{3} + r_{3} x^{2} y + 2 \\, x y^{2}\\right)} z^{2} - {\\left(r_{2} x - r_{3}\\right)} y - {\\left(r_{3} x^{3} - r_{2} x^{2} - r_{2} y^{2} + y^{3} + {\\left({\\left(r_{1} + 1\\right)} x^{2} + r_{1} - 1\\right)} y\\right)} z}{2 \\, x y^{2} z^{2} - y z^{3} - {\\left(y^{3} + {\\left(x^{2} - 1\\right)} y\\right)} z} &amp; \\frac{y^{2} z^{4} + r_{1} x^{2} y^{2} - r_{3} x y^{3} - {\\left(2 \\, x y^{3} - {\\left(r_{2} x - r_{3}\\right)} y^{2} + r_{2} x + x y\\right)} z^{3} + {\\left({\\left(r_{3} x - r_{2}\\right)} y^{3} + y^{4} + r_{1} x^{2} + r_{3} x y - {\\left({\\left(r_{1} - 3\\right)} x^{2} - r_{1} + 1\\right)} y^{2}\\right)} z^{2} - {\\left(r_{2} x^{2} - r_{3} x\\right)} y + {\\left(r_{2} x y^{2} - x y^{3} - r_{3} x^{2} + r_{2} x - {\\left(x^{3} + {\\left(2 \\, r_{1} - 1\\right)} x\\right)} y\\right)} z}{2 \\, x y^{2} z^{2} - y z^{3} - {\\left(y^{3} + {\\left(x^{2} - 1\\right)} y\\right)} z} &amp; r_{3} \\\\\n\\frac{y^{2} z^{4} + r_{1} x^{2} y^{2} - r_{3} x y^{3} - {\\left(2 \\, x y^{3} - {\\left(r_{2} x - r_{3}\\right)} y^{2} + r_{2} x + x y\\right)} z^{3} + {\\left({\\left(r_{3} x - r_{2}\\right)} y^{3} + y^{4} + r_{1} x^{2} + r_{3} x y - {\\left({\\left(r_{1} - 3\\right)} x^{2} - r_{1} + 1\\right)} y^{2}\\right)} z^{2} - {\\left(r_{2} x^{2} - r_{3} x\\right)} y + {\\left(r_{2} x y^{2} - x y^{3} - r_{3} x^{2} + r_{2} x - {\\left(x^{3} + {\\left(2 \\, r_{1} - 1\\right)} x\\right)} y\\right)} z}{2 \\, x y^{2} z^{2} - y z^{3} - {\\left(y^{3} + {\\left(x^{2} - 1\\right)} y\\right)} z} &amp; \\frac{r_{1} x^{3} y^{2} - r_{3} x^{2} y^{3} + {\\left(y^{3} - r_{2} - y\\right)} z^{3} - {\\left(2 \\, x y^{4} - {\\left(r_{2} x - r_{3}\\right)} y^{3} - 2 \\, x y^{2} - r_{1} x - r_{3} y\\right)} z^{2} - {\\left(r_{2} x^{3} - r_{3} x^{2}\\right)} y + {\\left(r_{2} x^{2} y^{2} + {\\left(r_{3} x - r_{2}\\right)} y^{4} + y^{5} - {\\left({\\left(r_{1} - 1\\right)} x^{2} - r_{1} + 2\\right)} y^{3} - r_{3} x - {\\left({\\left(r_{1} + 1\\right)} x^{2} + r_{1} - 1\\right)} y + r_{2}\\right)} z}{2 \\, x y^{2} z^{2} - y z^{3} - {\\left(y^{3} + {\\left(x^{2} - 1\\right)} y\\right)} z} &amp; r_{2} \\\\\nr_{3} &amp; r_{2} &amp; r_{1}\n\\end{array}\\right)$</div>"}︡{"done":true}
︠3c034a3b-8d2c-4b6c-b08e-62684797c756s︠
#------- first containment

Sigma=makeMatrix(1/2,1/3,1/4)
Sigma.is_positive_definite()
S=T.subs(x=1/2,y=1/3,z=1/4) #reverse engineer a data matrix to have a critical point at (1/2,1/3,1/4)
Q=2*S-Sigma

︡47ce50ec-c4ce-4a1d-9105-0fd8ac00a04a︡{"stdout":"True\n"}︡{"done":true}
︠f1e71945-e196-46c3-83ca-5504a63aae8as︠
pS=S.subs(r1=1,r2=1/9,r3=1/30); pS; print()
︡b952c526-2f46-40c2-a139-13c76e264421︡{"stdout":"[1211/4560 -217/3420      1/30]\n[-217/3420  827/2565       1/9]\n[     1/30       1/9         1]\n\n"}︡{"done":true}
︠74ce1107-8adf-4f26-867d-3da7cb6ff8e7s︠
crits=[(0.5,0.333333,0.25),(-0.73841,0.213623,-0.0580265),(0.182141,0.316592,0.190067)] #found in Macaulay2
︡0f60fb46-8ec2-4a47-8d58-7b9f57784b62︡{"done":true}
︠70ed5114-a091-4a4e-b7eb-a8351cc5692es︠
good_crits=[]
for c in crits:
    if makeMatrix(c[0],c[1],c[2]).is_positive_definite():
        likelihood(makeMatrix(c[0],c[1],c[2]),pS); print()
︡73aedc88-42d6-48aa-801b-d7d189e3934d︡{"stdout":"-1.53844955693696\n\n-1.24750351572487\n\n-1.55375020617405\n\n"}︡{"done":true}
︠0555b06c-cb7f-4600-a631-3eb665f93d0cs︠



#------- second containment
S.subs(r1=1/3,r2=1/3,r3=1/2) #take a matrix in the log-normal spectrahedron but with a different set of parameters

S.subs(r1=1/3,r2=1/3,r3=1/2).is_positive_definite()
Q.subs(r1=1/3,r2=1/3,r3=1/2).is_positive_definite()
︡b0e2bee1-e773-4724-9107-102a08b39ce0︡{"stdout":"[813/304  103/76     1/2]\n[ 103/76   85/57     1/3]\n[    1/2     1/3     1/3]\n"}︡{"stdout":"True\n"}︡{"stdout":"False\n"}︡{"done":true}









