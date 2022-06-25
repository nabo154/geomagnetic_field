#include <iostream>
#include <string>
#include <vector>
#include <fstream>

#include <io.h>
using namespace std;

void getFileNames(string path, vector<string>& files);

int main() {
	vector<string> fileNames;
	string path("C:/Users/yyfnj/Downloads/Homework3/Raw_data/"); 	
	getFileNames(path, fileNames);

	ofstream ofs;
	ofs.open("filename.dat", ios::trunc);

	for (const auto& ph : fileNames) {
		ofs << ph << "\n";
	}
	ofs.close();
	return 0;
}

void getFileNames(string path, vector<string>& files)
{
	
	intptr_t hFile = 0;
	struct _finddata_t fileinfo;
	string p;
	if ((hFile = _findfirst(p.assign(path).append("\\*").c_str(), &fileinfo)) != -1)
	{
		do
		{
			if ((fileinfo.attrib & _A_SUBDIR))
			{
				if (strcmp(fileinfo.name, ".") != 0 && strcmp(fileinfo.name, "..") != 0)
					getFileNames(p.assign(path).append(fileinfo.name), files);
			}
			else
			{
				files.push_back(p.assign(path).append(fileinfo.name));
			}
		} while (_findnext(hFile, &fileinfo) == 0);
		_findclose(hFile);
	}
}
