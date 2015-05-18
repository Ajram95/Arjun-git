//Arjun Ramaswamy, Final Integrated Project: Facial Recognition
//GE1111, 10:30-11:35 am, MWR
//Professor Jennifer Love
//Program 2
#include<iostream>
#include<fstream>
#include<conio.h>
#include<math.h>
using namespace std; 

void getinput(	double (&b)[200], double (&a)[100][100],double (&c)[200],double (&d)[200][200]){//Initializing multidimensional array
fstream fin1;
	fstream fin2;
	fin1.open("facialdistances.txt",ios::in); //Opening and reading the facialdistance values of candidates
	fin2.open("suspectsfacialdistances.txt",ios::in);//Opening and reading the facial distance values of suspects
	int x=0;
	int l=0;
	int f=0;
	int s=0;
	while(!fin1.eof()){ //while loop to calculate the 5 facial distance of every candidate
		fin1>>b[x]; 
		x++;
	}
		while(!fin2.eof()){ 
		fin2>>c[f];    
		f++;
	}
for(int i=0;i<=24;i++){//This entire loop selects distance 1-5 values of each candidate and each suspect
	for(int j=0;j<=4;j++)
	{
		a[i][j]=b[l];
		l++;
	}
}
for(int i=0;i<=2;i++){
	for(int j=0;j<=4;j++)
	{
		d[i][j]=c[s];
		s++;
	}
}
}

void output(double (&b)[200], double (&a)[100][100],double (&c)[200],double (&d)[200][200]){
double dist,dists; 
fstream fout1;
fout1.open("sumscores.txt",ios::out);
for(int i=0;i<=2;i++){
	fout1<<"Test for Candidate "<<(i+1)<<endl;
	for(int j=0;j<=24;j++)//Loop for calculating sumsquares between each candidate and suspect
	{
		dists=0;
		for(int k=0;k<=4;k++){
			dist= pow((a[j][k] - d[i][k]),2);// It uses the following structure: sumsquare = (distance1-distance1supect)^2 + (distance2-distance2suspect)^2....for every suspect
dists=dists+dist; 
		}
		fout1<<dists<<endl; 
	}
	fout1<<endl;
}
}

int main()
{
	double b[200],a[100][100],c[200],d[200][200];
	getinput(b,a,c,d);
	output(b,a,c,d);

cout<<"The sumscores of each candidate in comparison to all three suspects has been written to a text file";//writes a text file with sumscores of all candidates, which is read by MATLAB
	
	return 0;
}
