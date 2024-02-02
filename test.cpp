#include <iostream>
#include <vector>
using namespace std;
template <typename... Args>
void printve(Args... args){
    int arr[]={(cout<<args<<',',0)...};
    cout<<endl;
}
int main(){
    
    printve(1,2,3,'c',"hela",1.2);
}