%Código para resolver tiro parabólico con resistencia
%Luis Felipe Villaseñor A01023976
%Agustin Pumarejo Ontañon A01028997
%Alan Gómez Arias A01027781
%Rafael Padilla Palencia A01750434
%Eduardo Galindo Rojas Loa A01028846
clear all

fprintf('-----Tiro parabólico con resistencia-----\n');

kr=input('Dame el valor de k: ');

a=@(t) 1.3.^(t.*0.01+28)-550;
b=@(t) 1.3.^(-t.*0.01+28)-550;
c=@(t) 0.003*t.^2+650

mallaT1=(-400:0.1:-90);
mallaX1=a(mallaT1);

mallaT2=(90:0.1:400);
mallaX2=b(mallaT2);

mallaT3=(-90:0.1:90);
mallaX3=c(mallaT3);

figure(1)
plot(mallaT1, mallaX1,"r","LineWidth",5)
hold on
plot(mallaT2, mallaX2,"r","LineWidth",5)
hold on
plot(mallaT3, mallaX3,"r","LineWidth",5)

for i=1:10

y0=650;
x0=0;
v0=45+rand*20;

b=rand;
if b>0.5
    theta=30+rand*40;
    
else
    theta=110+rand*40;
end    

mass=10+rand*60000;

thetaRad=theta*(pi/180);
v0x=v0*cos(thetaRad);
v0y=v0*sin(thetaRad);
d=2800;
r=((3*mass)/(4*pi*d))^(1/3);

g=9.81;%m/s^2
tf=100;

c0x=[x0,v0x,y0,v0y];%Condiciones iniciales x

fg=@(t,x) [x(2);-(kr*x(2)*sqrt(x(2)^2+x(4)^2))/mass;x(4);-g-(kr*x(4)*sqrt(x(4)^2+x(2)^2))/mass];
[t,x]=ode45(fg,[0:0.1:tf],c0x);%Integra mi sistema de ecuaciones
longitud=length(t);

figure(1)
title("Volcán");
ylabel("Altura (m)")
xlabel("Alcance (m)")


a=0;
 col=rand(1,3);
for k=1:longitud
   
    if x(k,3)>=0
        plot(x(k,1),x(k,3),'o','Color',col)
        cuadro1=text(x(k,1)+50,x(k,3),["V=",num2str(sqrt(x(k,2)^2+x(k,4)^2)) ...
            ,"Vx=",num2str(x(k,2)),"Vy=",num2str(x(k,4))])
        drawnow
        delete(cuadro1)
        hold on
    end
    if (x(k,3)<=0)&(a==0)
        plot([(x(k,1)-r),(x(k,1)+r)],[0,0],'r','LineWidth',5)
        a=1;
    end
    
end  

end