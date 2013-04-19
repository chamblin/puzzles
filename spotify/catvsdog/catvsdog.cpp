#include <iostream>
#include <string>
#include <vector>
#include <queue>

using namespace std;

class CatVsDogVote{
	public:
		CatVsDogVote(string keep, string drop){
			this->lovesCats = (keep[0] == 'C');
			this->keep = atoi(keep.substr(1).c_str());
			this->drop = atoi(drop.substr(1).c_str());
		}
		
		int getKeep(){
			return this->keep;
		}
		
		int getDrop(){
			return this->drop;
		}
		
		bool catLover(){
			return this->lovesCats;
		}
		
		bool dogLover(){
			return (!this->catLover());
		}
		
		bool agreeableWith(CatVsDogVote *vote){
			if(this->catLover() == vote->catLover()){
				return true;
			}
			else{
				return this->agreeableWithOpposite(vote);
			}
		}
		
		bool agreeableWithOpposite(CatVsDogVote *vote){
			return ((this->keep != vote->getDrop()) && (this->drop != vote->getKeep()));
		}
		
		bool disagreeableWithOpposite(CatVsDogVote *vote){
			return !this->agreeableWithOpposite(vote);
		}
		
		bool fullyDisagreeableWithOpposite(CatVsDogVote *vote){
			return ((this->keep == vote->getDrop()) && (this->drop == vote->getKeep()));
		}
		
	private:
		int keep, drop;
		bool lovesCats;
};

class Strategy{
	public:
		virtual int maximumCliqueSize() = 0;
};

class HopcroftKarpStrategy : public Strategy{
	public:
		HopcroftKarpStrategy(int cats, int dogs, const vector<CatVsDogVote *> & votes){
			this->cats = cats;
			this->dogs = dogs;
			this->votes = votes;
		}
		
		int maximumCliqueSize(){
			this->bisectGraph();
			for(int i=0; i<this->votes.size(); i++){
				pairCats[i] = NIL;
				pairDogs[i] = NIL;
			}
			
			int matching = 0;
			
			while(this->bfs()){
				for(vector<int>::iterator catIterator = this->catVotes.begin(); catIterator != this->catVotes.end(); catIterator++){
					if((pairCats[*catIterator] == NIL) && this->dfs(*catIterator)){
						matching++;
					}
				}
			}
			return this->votes.size() - matching;
		}
		
	protected:
		const static int MAX = 1000;
		const static int NIL = -1;
		const static int INFINITY = 999; // this is approximate.
		
		int cats, dogs, pairCats[MAX], pairDogs[MAX], dist[MAX];
		vector<CatVsDogVote *> votes;
		vector<int> catVotes, dogVotes;
		
		bool bfs(){
			queue<int> Q;
			for(vector<int>::iterator catIterator = this->catVotes.begin(); catIterator != this->catVotes.end(); catIterator++){
				if(pairCats[*catIterator] == NIL){
					dist[*catIterator] = 0;
					Q.push(*catIterator);
				}
				else{
					dist[*catIterator] = INFINITY;
				}
			}
			
			dist[NIL] = INFINITY;
			
			while(!Q.empty()){
				int cat = Q.front();
				if(cat != NIL){
					for(vector<int>::iterator dogIterator = this->dogVotes.begin(); dogIterator != this->dogVotes.end(); dogIterator++){
						if(this->votes[cat]->disagreeableWithOpposite(this->votes[*dogIterator])){
							if(dist[pairDogs[*dogIterator]] == INFINITY){
								dist[pairDogs[*dogIterator]] = dist[cat] + 1;
								Q.push(pairDogs[*dogIterator]);
							}
						}
					}
				}
				Q.pop();
			}
			
			return dist[NIL] != INFINITY;
		}
		
		bool dfs(int cat){
			if(cat != NIL){
				for(vector<int>::iterator dogIterator = this->dogVotes.begin(); dogIterator != this->dogVotes.end(); dogIterator++){
					if(this->votes[cat]->disagreeableWithOpposite(this->votes[*dogIterator])){
						if(dist[pairDogs[*dogIterator]] == (dist[cat] + 1)){
							if(dfs(pairDogs[*dogIterator])){
								pairDogs[*dogIterator] = cat;
								pairCats[cat] = *dogIterator;
								return true;
							}
						}
					}
				}
				dist[cat] = INFINITY;
				return false;
			}
			return true;
		}
		
		void bisectGraph(){
			for(int i=0; i<this->votes.size(); i++){
				if(this->votes[i]->catLover())
					this->catVotes.push_back(i);
				else
					this->dogVotes.push_back(i);
			}
		}
		
};

class CatVsDogDataSet{
	public:
		CatVsDogDataSet(int cats, int dogs, int votes){
			this->cats = cats;
			this->dogs = dogs;
			this->votes.reserve(votes);
		}
		
		int maximumCliqueSize(){
			return this->getStrategy()->maximumCliqueSize();
		}
		
		void addVote(CatVsDogVote *vote){
			this->votes.push_back(vote);
		}
		
		
	private:
		vector<CatVsDogVote*> votes;
		
		vector<int> colors;
		
		int cats;
		int dogs;
		int catLovers;
		int championSize;
		
		Strategy * getStrategy(){
			return new HopcroftKarpStrategy(this->cats, this->dogs, this->votes);
		}
};

class CatVsDogDataSets{
	public:
		CatVsDogDataSets(int sets){
			this->sets = sets;
		}
		
		vector<int> findMaximumCliques(){
			vector<int> ret;
			for(int i=0; i<this->dataSets.size(); i++){
				ret.push_back((this->dataSets[i])->maximumCliqueSize());
			}
			return ret;
		}
		
		void addSet(CatVsDogDataSet * set){
			this->dataSets.push_back(set);
		}
		
	private:
		int sets;
		vector<CatVsDogDataSet *> dataSets;
};

class CatVsDogParser{
	public:
		CatVsDogParser(){
		}
		
		CatVsDogDataSets * dataSets(){
			this->read();
			return this->dataSet;
		}
		
		~CatVsDogParser(){
			//delete this->sets;
		}
	
	private:
		int numberOfDataSets;
		CatVsDogDataSets * dataSet;
		
		void read(){
			string line;
			cin >> this->numberOfDataSets; 
			CatVsDogDataSets * cvds = new CatVsDogDataSets(this->numberOfDataSets); 
			this->dataSet = cvds;
			this->readDataSets();
		}
		
		void readDataSets(){
			for(int i=0;i<this->numberOfDataSets;i++){
				this->readDataSet();
			}
		}
		
		void readDataSet(){
			int cats, dogs, voters;
			cin >> cats >> dogs >> voters;
			CatVsDogDataSet *set = new CatVsDogDataSet(cats, dogs, voters);
			for(int i=0;i < voters; i++){
				string keep, drop;
				cin >> keep;
				cin >> drop;
				CatVsDogVote *vote = new CatVsDogVote(keep, drop);
				set->addVote(vote);
			}
			this->dataSet->addSet(set);
		}
};

int main(){
	CatVsDogParser *cvdp = new CatVsDogParser();
	vector<int> champs = cvdp->dataSets()->findMaximumCliques();
	for(int i=0; i<champs.size(); i++){
		cout << champs[i] << endl;
	}
	delete cvdp;
	return 0;
}