## Homework 3

## 杨艺飞 12032532

1. 选择时间：2019-11-21 取样频率：minute date 数据类型：quasi-definitive 数据格式：IAGA2002

下载所有的观测站的数据，保存于./Raw_data/ 文件夹下。

每一个观测站的数据为一个文本文件，包含该观测站的经纬度，坐标系，采样时间等信息，每分钟采样一次，包含XYZ分量及强度F。

去掉非XYZF坐标系下的观测站数据，已经F显示为9999的异常数据站点。考虑到空间分布，使用的观测站在地图上的分布如下：一共45个台站的数据

![1_Points](C:\Users\yyfnj\Documents\我的坚果云\高等地球电磁学\杨艺飞_Homework3\1_Points.jpg)

保存于 ./1_Points.jpg

2. 使用c++程序 getFileName.cpp 读取./Raw_data/文件夹之下的所有文本文件的绝对路径，并保存于文件./filename.dat之中。

3. 使用c++程序 calculate_mean_value.cpp 计算每一个观测点的XYZF分量的平均值，作为该观测点当天的均值。结果保存于文件./2_Used_date.txt文件中。

文件示例：序号 维度 经度 X分量 Y分量 Z分量 总强度

>  1    abk       68.4    18.8     11248.6     1855.67     52124.1

4. 使用matlab程序 geomagnetic_field.m 计算高斯系数。结果保存于文件 3_Gauss_coefficient.txt文件之中。

   | 高斯系数 | 20191121   | IGRF13   |
   | -------- | ---------- | -------- |
   | $g_1^0$  | -29634.790 | -29404.8 |
   | $g_1^1$  | -1190.385  | -1450.9  |
   | $h_1^1$  | 4624.359   | 4652.5   |
   | $g_2^0$  | -2444.820  | -2499.6  |
   | $g_2^1$  | 2880.613   | 2982.0   |
   | $h_2^1$  | -3061.196  | -2991.6  |
   | $g_2^2$  | 1133.635   | 1677.0   |
   | $h_2^2$  | -181.037   | -734.6   |
   | $g_3^0$  | 1210.834   | 1363.2   |
   | $g_3^1$  | -2371.993  | -2381.2  |
   | $h_3^1$  | -293.632   | -82.1    |
   | $g_3^2$  | 1762.922   | 1236.2   |
   | $h_3^2$  | 685.226    | 241.9    |
   | $g_3^3$  | -112.790   | 525.7    |
   | $h_3^3$  | -325.208   | -543.4   |
   | $g_4^0$  | 1111.280   | 903.0    |
   | $g_4^1$  | 1077.549   | 809.5    |
   | $h_4^1$  | 532.940    | 281.9    |
   | $g_4^2$  | 266.942    | 86.3     |
   | $h_4^2$  | -84.980    | -158.4   |
   | $g_4^3$  | -632.937   | -309.4   |
   | $h_4^3$  | 95.314     | 199.7    |
   | $g_4^4$  | 240.506    | 48.0     |
   | $h_4^4$  | -1297.572  | -349.7   |

   

5. 使用matlab程序 draw_geomagnetic_field.m 画出使用计算得出的高斯系数绘制全球地磁场模型的总强度场和径向分量，倾角以及水平角。

   <img src="C:\Users\yyfnj\Documents\我的坚果云\高等地球电磁学\杨艺飞_Homework3\4_total_field_intensity.jpg" alt="4_total_field_intensity" style="zoom: 50%;" />

   <img src="C:\Users\yyfnj\Documents\我的坚果云\高等地球电磁学\杨艺飞_Homework3\4_radial_component.jpg" alt="4_radial_component" style="zoom: 50%;" />

   <img src="C:\Users\yyfnj\Documents\我的坚果云\高等地球电磁学\杨艺飞_Homework3\4_inclination.jpg" alt="4_inclination" style="zoom:50%;" />

   <img src="C:\Users\yyfnj\Documents\我的坚果云\高等地球电磁学\杨艺飞_Homework3\4_decilnation.jpg" alt="4_decilnation" style="zoom:50%;" />

6. 使用matlab程序 draw_geomagnetic_field_using_igrf13_coeffs.m 画出使用IGRF-13模型高斯系数绘制全球地磁场模型的总强度场和径向分量，倾角以及水平角。

<img src="C:\Users\yyfnj\Documents\我的坚果云\高等地球电磁学\杨艺飞_Homework3\4_total_field_intensity_using_igrf13.jpg" alt="4_total_fielf_intensity_using_igrf13" style="zoom:50%;" />

<img src="C:\Users\yyfnj\Documents\我的坚果云\高等地球电磁学\杨艺飞_Homework3\4_radial_component_using_igrf13.jpg" alt="4_radial_component_using_igrf13" style="zoom:50%;" />

<img src="C:\Users\yyfnj\Documents\我的坚果云\高等地球电磁学\杨艺飞_Homework3\4_decilnation_using_igrf13.jpg" alt="4_decilnation_using_igrf13" style="zoom:50%;" />

<img src="C:\Users\yyfnj\Documents\我的坚果云\高等地球电磁学\杨艺飞_Homework3\4_inclination_using_igrf13.jpg" alt="4_inclination_using_igrf13" style="zoom:50%;" />

4. 使用matlab程序plot_spectra.m画出前N阶谱。蓝色线代表20191121高斯系数，橙色线代表使用IGRF13高斯系数。

![5_spectrum_in_SH_degree](C:\Users\yyfnj\Documents\我的坚果云\高等地球电磁学\杨艺飞_Homework3\5_spectrum_in_SH_degree.jpg)

从谱图可以看出，随着n增大，S(n)快速衰减，地球磁场可以近似为一个偶极磁场，地磁场在地球表面约10-60μT.赤道处磁场最弱，两极最强。

