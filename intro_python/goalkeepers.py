# show that the median of GK's heights is larger than the median of non-GK
import pandas as pd
import numpy as np

fifa = pd.read_csv("fifa.csv")
np_fifa = fifa.values

np_position = np.array(np_fifa[:,3])
np_height = np.array(np_fifa[:,4])

gk = np_height[ np_position == ' GK']
gk_median = np.median(gk)

other = np_height[np_position != ' GK']
other_median = np.median(other)

print("Median GK=" + str(gk_median))
print("Median Non-GK=" + str(other_median))
