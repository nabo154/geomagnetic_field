#include<iostream>
#include<fstream>
#include<string>
#include<iomanip>
using namespace std;
int main() {
	ifstream ifs;
	ifs.open("C:/Users/yyfnj/Downloads/Homework3/filename.dat");
	const int Number_of_Files = 45;
	string names[Number_of_Files];
	for (int i = 0; i < Number_of_Files; i++) {
		getline(ifs, names[i]);
	}

	ifs.close();

	for (int index = 0; index < Number_of_Files; index++) {
		ifs.open(names[index]);
		if (!ifs.is_open()) {
			cout << "fail to open" << names[index] << endl;
		}

		string buf;

		for (int i = 0; i < 4; i++) {
			getline(ifs, buf);
		}

		string str1;
		string str2;
		string str3;

		float latitude = 0;
		float longitude = 0;

		ifs >> str1;
		ifs >> str2;
		
		ifs >> latitude;
		ifs >> str3;

		
		ifs >> str1;
		ifs >> str2;
		
		ifs >> longitude;
		ifs >> str3;
		

		for (int i = 6; i < 23; i++) {
			getline(ifs, buf);
			if (i == 22) {
				cout << buf << endl;
			}	
		}

		string date, time, doy;
		float x, y, z, f;

		double x_total = 0;
		double y_total = 0;
		double z_total = 0;

		for (int i = 0; i < 1440; i++) {
			ifs >> date;
			ifs >> time;
			ifs >> doy;
			ifs >> x;
			ifs >> y;
			ifs >> z;
			ifs >> f;
			x_total += x;
			y_total += y;
			z_total += z;
		}

		ofstream ofs;
		ofs.open("result.dat", ios::app);
		float minutes = 1440;
		string name = names[index];

		
		ofs << setw(2) << index + 1 << "    "<<name[44]<<name[45]<<name[46]<<"   "<<
			setw(8) << latitude <<
			setw(8) << longitude << 
			setw(12) << x_total / minutes <<
		    setw(12) << y_total / minutes <<
		    setw(12) << z_total / minutes << endl;
		

		
		//ofs << setw(12) << x_total / minutes << endl;
		//ofs << setw(12) << y_total / minutes << endl;
		//ofs << setw(12) << z_total / minutes << endl;
		

		//ofs << setw(2) << index + 1 << setw(8) << latitude << setw(8) << longitude << endl;
		
		ifs.close();
	}
	return 0;
}