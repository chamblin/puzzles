#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main(){
	int k, n;
	cin >> n >> k;
	vector<int> flowers;
	for(int i=0; i < n; i++){
		int flower;
		cin >> flower;
		flowers.push_back(flower);
	}
	sort(flowers.begin(), flowers.end());
	int multiplier = 1;
	int cost = 0;
	while(!flowers.empty()){
		int sum = 0;
		for(int i=0; (i<k) && (!flowers.empty()); i++){
			sum += flowers.back();
			flowers.pop_back();
		}
		cost += (sum * multiplier);
		multiplier++;
	}
	cout << cost << endl;
}