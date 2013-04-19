#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main(){
	int n, k;
	int count = 0;
	cin >> n >> k;
	
	vector<int> numbers;
	for(int i=0; i < n; i++){
		int num;
		cin >> num;
		numbers.push_back(num);
	}
	
	sort(numbers.begin(), numbers.end());
	for(vector<int>::iterator biggest = numbers.end()-1; biggest > numbers.begin(); biggest--){
		for(vector<int>::iterator i=numbers.end()-1; ((*biggest)-*i)<=k; --i){
			if(((*biggest)-(*i)) == k){
				count++;
			}
		}
	}
	cout << count << endl;
	return 0;
}