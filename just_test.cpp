#include <memory>
#include <iostream>
#include <string>
#include <algorithm>
#include <hash_map>
using namespace std;

// struct A { A(){ cout << "A"; } };
// struct B { B(){ cout << "B"; } };
// struct C { C(){ cout << "C"; } };
// struct D { D(){ cout << "D"; } };
// 
// struct E : D { E(){ cout << "E"; } }; // DE
// 
// struct F : A, B {                     //A, B
//     //stack 
//     C c; //C
//     D d; //D
//     E e; // DE 
// 
//     F() : B(), A(),d(),c(),e() { cout << "F"; }
// }; 



// struct A { ~A(){ cout << "A"; } };
//

// struct A            { A(){cout << "A()" << endl;}; virtual void f(){ cout << "A->f()" << endl; }; virtual ~A(){cout << "~A()" << endl;}};
// struct B : public A { B(){cout << "B()" << endl;}; virtual void f(){ cout << "B->f()" << endl; }; virtual ~B(){cout << "~B()" << endl;}};
// struct C : public B { C(){cout << "C()" << endl;}; virtual void f(){ cout << "C->f()" << endl; }; virtual ~C(){cout << "~C()" << endl;}};
// struct D : public C { D(){cout << "D()" << endl;}; virtual void f(){ cout << "D->f()" << endl; }; virtual ~D(){cout << "~D()" << endl;}};
// struct F : public D { F(){cout << "F()" << endl;};         void f(){ cout << "F->f()" << endl; };         ~F(){cout << "~F()" << endl;}};


int 
main(void)
{
    // F f;

    // A *p = new A[10];
    // delete p;
    
    // A *p = 0;
    // delete p;

    // A *a = new F;
    // a->f();
    // delete a;


    // char value = 0xff;
    // cout << hex << static_cast<int>(value) << endl;

    // value &= 0xffffffff;
    // cout << hex << value << endl;
    //
    
    // int a, b;
    // a = 3;
    // b = 5;
    // swap(a, b);
    // cout << a << " " << b << endl;


    return 0;
}
