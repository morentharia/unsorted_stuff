

```python
from IPython.display import display, Math, Latex
from sympy import *
import sympy
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm

# %matplotlib inline
#init_printing()

# x = np.linspace(-6, 19, 200)
# plt.cla()
# plt.plot(x, norm.pdf(x, loc=0, scale=1), 'r-', lw=2, label='norm')
# plt.plot(x, norm.pdf(x, loc=mu, scale=sigma), label='hahah')
# plt.legend(loc='best', frameon=False)
# plt.plot()

def P_popadaniya_v_interval(left, right, mu=0, sigma=None, disp=None, title=""):
    
    if sigma is None and disp is None:     
        raise StandardError('WTF!!')
    elif sigma and disp:
        raise StandardError('WTF!!')
    elif sigma is None and disp:
        sigma = float(sqrt(float(disp)))
        sigma_str = r'\sqrt{' + str(disp) + r'}'
    elif sigma and disp is None:
        sigma = sigma
        sigma_str = str(sigma).rstrip('.0')
        
    
    mu_str = str(mu)            
    right_str = str(right)
    left_str = str(left)
    z_right = "%.3f" % ((right - mu)/sigma)
    z_left = "%.3f" % ((left - mu)/sigma)
    F_right_str = "%.3f" % norm.cdf((right - mu)/sigma)
    F_left_str = "%.3f" % norm.cdf((left - mu)/sigma)
    res = "%.3f" % (norm.cdf((right - mu)/sigma) - norm.cdf((left - mu)/sigma))

    tex_tmp = '\n'.join([
    r'$',
    title, r'\\',
    r'\mu=', mu_str , r',  '
    ])
    
    if disp:
        tex_tmp += r'D=' + str(disp) + r', '
        
    tex_tmp += '\n'.join([              
    r'\sigma=', sigma_str , r'\\'
    r'P(', left_str, r' < x <', right_str, r') = ',
    r'Ф(\frac{', right_str, ' - \mu}{\sigma}) - ',
    r'Ф(\frac{', left_str, r' - \mu}{\sigma}) = ', 
    r'Ф(\frac{', right_str, ' - ', mu_str,'}{', sigma_str,'}) - ',
    r'Ф(\frac{', left_str, r' - ', mu_str, r'}{', sigma_str, r'}) = \\ ', 
    r'= Ф(', z_right, r') - ',
    r'Ф(', z_left, r') = ', 
    F_right_str, ' - ', F_left_str, r' = ',      
    res,
    r'$'      
    ])
    display(Latex(tex_tmp))
  
def get_x_from_F_ot_x(F_x, mu=0, sigma=None, disp=None, title=""):
    if sigma is None and disp is None:     
        raise StandardError('WTF!!')
    elif sigma and disp:
        raise StandardError('WTF!!')
    elif sigma is None and disp:
        sigma = float(sqrt(float(disp)))
        sigma_str = r'\sqrt{' + str(disp) + r'}'
    elif sigma and disp is None:
        sigma = sigma
        sigma_str = str(sigma).rstrip('.0')
        
    ppf = norm.ppf(F_x)
    ppf_str = "%.3f" % ppf
    
    x = sigma * ppf + mu
    x_str = "%.3f" % x
    
    mu_str = str(mu)            
    tex_tmp = '\n'.join([
    r'$',
    title, r'\\',
    r'\mu=', mu_str , r',  '
    ])
        
    if disp:
        tex_tmp += r'D=' + str(disp) + r', '
        
    tex_tmp += '\n'.join([              
    r'\sigma=', sigma_str, r'\\'
    r'Ф(\frac{x - \mu}{\sigma}) = ' + str(F_x) + r'\\ ',
    r'Ф(\frac{x - ', mu_str, '}{', sigma_str,'}) = ' + str(F_x) + r'\\',
    r'\frac{x - ', mu_str, '}{', sigma_str,'} = ' + ppf_str + r'\\',
    r'x = ' + sigma_str +'*' + ppf_str + ' + ' + mu_str + r'\\',
    r'x = ' + x_str + r'\\',            
    r'$'      
    ])
    display(Latex(tex_tmp))
  

    

```


```python
# ================================================================
P_popadaniya_v_interval(title='4A)', left=13.0, right=17.0, mu=14.0, sigma=2.0)
P_popadaniya_v_interval(title='4Б)', left=16.2, right=float('inf'), mu=14.0, sigma=2.0)
get_x_from_F_ot_x(title='5) Найдем~максимальное~время~25\%~лучших~гонщиков',
                  F_x=0.25, mu=62.5, sigma=5.8)
P_popadaniya_v_interval(title='6)', left=37.0, right=49.0, mu=46.0, disp=36.0)
P_popadaniya_v_interval(title='7A)', left=-0.62, right=2.13, mu=0., sigma=1.0) 
P_popadaniya_v_interval(title='7Б)', left=-1.83, right=-1.06, mu=0., sigma=1.0) 
P_popadaniya_v_interval(title='7В)', left=0.39, right=1.76, mu=0., sigma=1.0) 
P_popadaniya_v_interval(title='8A)', left=-float('inf'), right=48.8, mu=50.0, disp=1.44)
P_popadaniya_v_interval(title='8Б)', left=49.3, right=float('inf'), mu=50.0, disp=1.44) 
P_popadaniya_v_interval(title='8Б)', left=49.2, right=50.4, mu=50., disp=1.44) 
P_popadaniya_v_interval(title='9)', left=500., right=float('inf'), mu=400.0, sigma=100.0) 
get_x_from_F_ot_x(title=r'10)\\P(X \le x) = 0.4 ~PS~посмотри~ в ~задачнике ~ \le~или\ge', F_x=0.4, mu=20.0, disp=36.0)
get_x_from_F_ot_x(title=r'11)\\P(X \le x) = 0.6 ~PS~посмотри~ в ~задачнике', F_x=0.6, mu=10.0, disp=9.0)
P_popadaniya_v_interval(title='12)', left=16., right=43., mu=25.0, disp=9.0) 
P_popadaniya_v_interval(title='13A)', left=200.0, right=float('inf'), mu=202.0, sigma=5.0) 
P_popadaniya_v_interval(title='13Б)', left=195.0, right=205.0, mu=202.0, sigma=5.0) 

```


$
4A)
\\
\mu=
14.0
,  \sigma=
2
\\P(
13.0
 < x <
17.0
) = 
Ф(\frac{
17.0
 - \mu}{\sigma}) - 
Ф(\frac{
13.0
 - \mu}{\sigma}) = 
Ф(\frac{
17.0
 - 
14.0
}{
2
}) - 
Ф(\frac{
13.0
 - 
14.0
}{
2
}) = \\ 
= Ф(
1.500
) - 
Ф(
-0.500
) = 
0.933
 - 
0.309
 = 
0.625
$



$
4Б)
\\
\mu=
14.0
,  \sigma=
2
\\P(
16.2
 < x <
inf
) = 
Ф(\frac{
inf
 - \mu}{\sigma}) - 
Ф(\frac{
16.2
 - \mu}{\sigma}) = 
Ф(\frac{
inf
 - 
14.0
}{
2
}) - 
Ф(\frac{
16.2
 - 
14.0
}{
2
}) = \\ 
= Ф(
inf
) - 
Ф(
1.100
) = 
1.000
 - 
0.864
 = 
0.136
$



$
5) Найдем~максимальное~время~25\%~лучших~гонщиков
\\
\mu=
62.5
,  \sigma=
5.8
\\Ф(\frac{x - \mu}{\sigma}) = 0.25\\ 
Ф(\frac{x - 
62.5
}{
5.8
}) = 0.25\\
\frac{x - 
62.5
}{
5.8
} = -0.674\\
x = 5.8*-0.674 + 62.5\\
x = 58.588\\
$



$
6)
\\
\mu=
46.0
,  D=36.0, \sigma=
\sqrt{36.0}
\\P(
37.0
 < x <
49.0
) = 
Ф(\frac{
49.0
 - \mu}{\sigma}) - 
Ф(\frac{
37.0
 - \mu}{\sigma}) = 
Ф(\frac{
49.0
 - 
46.0
}{
\sqrt{36.0}
}) - 
Ф(\frac{
37.0
 - 
46.0
}{
\sqrt{36.0}
}) = \\ 
= Ф(
0.500
) - 
Ф(
-1.500
) = 
0.691
 - 
0.067
 = 
0.625
$



$
7A)
\\
\mu=
0.0
,  \sigma=
1
\\P(
-0.62
 < x <
2.13
) = 
Ф(\frac{
2.13
 - \mu}{\sigma}) - 
Ф(\frac{
-0.62
 - \mu}{\sigma}) = 
Ф(\frac{
2.13
 - 
0.0
}{
1
}) - 
Ф(\frac{
-0.62
 - 
0.0
}{
1
}) = \\ 
= Ф(
2.130
) - 
Ф(
-0.620
) = 
0.983
 - 
0.268
 = 
0.716
$



$
7Б)
\\
\mu=
0.0
,  \sigma=
1
\\P(
-1.83
 < x <
-1.06
) = 
Ф(\frac{
-1.06
 - \mu}{\sigma}) - 
Ф(\frac{
-1.83
 - \mu}{\sigma}) = 
Ф(\frac{
-1.06
 - 
0.0
}{
1
}) - 
Ф(\frac{
-1.83
 - 
0.0
}{
1
}) = \\ 
= Ф(
-1.060
) - 
Ф(
-1.830
) = 
0.145
 - 
0.034
 = 
0.111
$



$
7В)
\\
\mu=
0.0
,  \sigma=
1
\\P(
0.39
 < x <
1.76
) = 
Ф(\frac{
1.76
 - \mu}{\sigma}) - 
Ф(\frac{
0.39
 - \mu}{\sigma}) = 
Ф(\frac{
1.76
 - 
0.0
}{
1
}) - 
Ф(\frac{
0.39
 - 
0.0
}{
1
}) = \\ 
= Ф(
1.760
) - 
Ф(
0.390
) = 
0.961
 - 
0.652
 = 
0.309
$



$
8A)
\\
\mu=
50.0
,  D=1.44, \sigma=
\sqrt{1.44}
\\P(
-inf
 < x <
48.8
) = 
Ф(\frac{
48.8
 - \mu}{\sigma}) - 
Ф(\frac{
-inf
 - \mu}{\sigma}) = 
Ф(\frac{
48.8
 - 
50.0
}{
\sqrt{1.44}
}) - 
Ф(\frac{
-inf
 - 
50.0
}{
\sqrt{1.44}
}) = \\ 
= Ф(
-1.000
) - 
Ф(
-inf
) = 
0.159
 - 
0.000
 = 
0.159
$



$
8Б)
\\
\mu=
50.0
,  D=1.44, \sigma=
\sqrt{1.44}
\\P(
49.3
 < x <
inf
) = 
Ф(\frac{
inf
 - \mu}{\sigma}) - 
Ф(\frac{
49.3
 - \mu}{\sigma}) = 
Ф(\frac{
inf
 - 
50.0
}{
\sqrt{1.44}
}) - 
Ф(\frac{
49.3
 - 
50.0
}{
\sqrt{1.44}
}) = \\ 
= Ф(
inf
) - 
Ф(
-0.583
) = 
1.000
 - 
0.280
 = 
0.720
$



$
8Б)
\\
\mu=
50.0
,  D=1.44, \sigma=
\sqrt{1.44}
\\P(
49.2
 < x <
50.4
) = 
Ф(\frac{
50.4
 - \mu}{\sigma}) - 
Ф(\frac{
49.2
 - \mu}{\sigma}) = 
Ф(\frac{
50.4
 - 
50.0
}{
\sqrt{1.44}
}) - 
Ф(\frac{
49.2
 - 
50.0
}{
\sqrt{1.44}
}) = \\ 
= Ф(
0.333
) - 
Ф(
-0.667
) = 
0.631
 - 
0.252
 = 
0.378
$



$
9)
\\
\mu=
400.0
,  \sigma=
1
\\P(
500.0
 < x <
inf
) = 
Ф(\frac{
inf
 - \mu}{\sigma}) - 
Ф(\frac{
500.0
 - \mu}{\sigma}) = 
Ф(\frac{
inf
 - 
400.0
}{
1
}) - 
Ф(\frac{
500.0
 - 
400.0
}{
1
}) = \\ 
= Ф(
inf
) - 
Ф(
1.000
) = 
1.000
 - 
0.841
 = 
0.159
$



$
10)\\P(X \le x) = 0.4 ~PS~посмотри~ в ~задачнике ~ \le~или\ge
\\
\mu=
20.0
,  D=36.0, \sigma=
\sqrt{36.0}
\\Ф(\frac{x - \mu}{\sigma}) = 0.4\\ 
Ф(\frac{x - 
20.0
}{
\sqrt{36.0}
}) = 0.4\\
\frac{x - 
20.0
}{
\sqrt{36.0}
} = -0.253\\
x = \sqrt{36.0}*-0.253 + 20.0\\
x = 18.480\\
$



$
11)\\P(X \le x) = 0.6 ~PS~посмотри~ в ~задачнике
\\
\mu=
10.0
,  D=9.0, \sigma=
\sqrt{9.0}
\\Ф(\frac{x - \mu}{\sigma}) = 0.6\\ 
Ф(\frac{x - 
10.0
}{
\sqrt{9.0}
}) = 0.6\\
\frac{x - 
10.0
}{
\sqrt{9.0}
} = 0.253\\
x = \sqrt{9.0}*0.253 + 10.0\\
x = 10.760\\
$



$
12)
\\
\mu=
25.0
,  D=9.0, \sigma=
\sqrt{9.0}
\\P(
16.0
 < x <
43.0
) = 
Ф(\frac{
43.0
 - \mu}{\sigma}) - 
Ф(\frac{
16.0
 - \mu}{\sigma}) = 
Ф(\frac{
43.0
 - 
25.0
}{
\sqrt{9.0}
}) - 
Ф(\frac{
16.0
 - 
25.0
}{
\sqrt{9.0}
}) = \\ 
= Ф(
6.000
) - 
Ф(
-3.000
) = 
1.000
 - 
0.001
 = 
0.999
$



$
13A)
\\
\mu=
202.0
,  \sigma=
5
\\P(
200.0
 < x <
inf
) = 
Ф(\frac{
inf
 - \mu}{\sigma}) - 
Ф(\frac{
200.0
 - \mu}{\sigma}) = 
Ф(\frac{
inf
 - 
202.0
}{
5
}) - 
Ф(\frac{
200.0
 - 
202.0
}{
5
}) = \\ 
= Ф(
inf
) - 
Ф(
-0.400
) = 
1.000
 - 
0.345
 = 
0.655
$



$
13Б)
\\
\mu=
202.0
,  \sigma=
5
\\P(
195.0
 < x <
205.0
) = 
Ф(\frac{
205.0
 - \mu}{\sigma}) - 
Ф(\frac{
195.0
 - \mu}{\sigma}) = 
Ф(\frac{
205.0
 - 
202.0
}{
5
}) - 
Ф(\frac{
195.0
 - 
202.0
}{
5
}) = \\ 
= Ф(
0.600
) - 
Ф(
-1.400
) = 
0.726
 - 
0.081
 = 
0.645
$

