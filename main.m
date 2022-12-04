clc
% clear all
close('all')

img = imread('Obraz1.jpg');
fixations = readtable('User 0_fixations.csv');
T = readtable('User 0_fixations.csv');

% ------------------------------------

img_height = size(img , 1 ) ;
img_width = size(img , 2 ) ;
fix = fixations( 39 : 69 , [ 6 , 7 , 9 ] ) ;
xd = table2array (fix) ;
xd ( : , 1 ) = xd ( : , 1 )*img_width ;
xd ( : , 2 ) = xd ( : , 2 )*img_height ;
longest_fix =max(xd ( : , 3 ) ) ;
img_height =size(img , 1 ) ;
img_width =size(img , 2 ) ;

start = 11;
stop = 39;
X =int32 ( table2array (T( start : stop , 6 ) )*1365 ) ;
Y =int32 ( table2array (T( start : stop , 7 ) )*1024 ) ;
czas =table2array (T( start : stop , 9 ) ) ;
halfX = 1365/2;
x1 = 550;
x2 = halfX + 110;
halfY = 1024/2;
time1 = 0;
time2 = 0;
time3 = 0;
one_two=0;
one_three =0;
two_one=0;
two_three=0;
three_one =0;
three_two=0;
imshow ( img ) ;
hold on
xline((x1-45));
xline( x2 ) ;
previous = 0;
for i  =1:29
if X( i ) < x1
    time1 = time1 + czas ( i ) ;
 if previous == 2
     two_one = two_one + 1;
 elseif previous == 3
     three_one = three_one + 1;
 end
 previous = 1;
elseif X( i ) > x1 && X( i ) < x2
    time2 = time2 + czas ( i ) ;
    if previous == 1
        one_two = one_two + 1;
    elseif previous == 3
        three_two = three_two + 1;
    end
    previous = 2;
else
    time3 = time3 + czas ( i ) ;
    if previous == 1
        one_three = one_three + 1;
    elseif previous == 2
        two_three = two_three + 1;
    end
    previous = 3;
end
end
suma = one_two + one_three + two_one + two_three + three_one + three_two ;
xd1 = one_three/suma*100;
xd2 = two_one/suma*100;
xd3 = two_three/suma*100;
xd4 = three_two/suma*100;
var1 = time1  /sum( czas ) ;
var2 = time2  /sum( czas ) ;
var3 = time3  /sum( czas ) ;
scatter(250 ,  550 ,  var1*50000 , 'filled' ) ;
text(200 ,  470 ,num2str( round(var1,4)*100)+"%" ,'FontSize', 15) ;
scatter(575 ,  768 ,  round(var2,4)*50000 , 'filled' ) ;
text(525 ,  775 ,num2str( round(var2,4)*100)+"%" ,  'FontSize' , 15) ;
scatter(1100 ,  600 ,  var3*50000 , 'filled' ) ;
text(1050 ,  690 ,num2str( round(var3,2)*100)+"%" ,  'FontSize' , 15) ;
quiver(250 ,  550 ,  1100-250/2, 512-550,'green' ) ;
text(275 ,  560 ,  append (num2str( round(xd1,2) ) ,  "%"));
quiver(575 ,  768 ,-300,-200, 'green' ) ;
text(500 ,  700 ,  append (num2str( round(xd2,2) ) ,  "%"));
quiver(575 ,  768 ,  600 ,-300, 'green' ) ;
text(600 ,  700 ,  append (num2str( round(xd3,2) ) ,  "%"));
quiver(1120 ,  540 ,-620,  320 , 'green' ) ;
text(1100 ,  575 ,  append (num2str( round(xd4,2) ) ,  "%"));
quiver(230,  600 , 300,  250 , 'green' ) ;
text(220 ,  610 ,  append (num2str(round(var1,4)*100) ,  "%"));