# head and tail let you select rows from a text file. If you want to select columns, you can use the command cut. 
# It has several options (use man cut to explore them), but the most common is something like:
# 
# cut -f 2-5,8 -d , values.csv
# which means 
# "select columns 2 through 5 and columns 8, using comma as the separator". 
# cut uses -f (meaning "fields") to specify columns and -d (meaning "delimiter") to specify the separator. You need to specify the latter because some files may use spaces, tabs, or colons to separate columns.
# 

cut -f 2 -d , seasonal/autumn.txt
# Use grep to not match
cut -f 2 -d , seasonal/autumn.txt | grep -v Tooth

# select the first column from the spring data;
cut -f 1 -d , seasonal/spring.txt
# remove the header line containing the word "Date"; and
grep -v Date
# select the first 10 lines of actual data.
head -n 10

# All together
cut -f 1 -d , seasonal/spring.txt | grep -v Date | head -n 10

# Write a pipeline to:
# 
# get the second column from all of the data files in seasonal,
# remove the word "Tooth" from the output so that only tooth names are displayed,
# sort the output so that all occurrences of a particular tooth name are adjacent; and
# display each tooth name once along with a count of how often it occurs.
# Use uniq -c to display unique lines with a count of how often each occurs.
cut -f 2 -d , seasonal/* | grep -v Tooth | sort | uniq -c

# To wrap up, you will build a pipeline to find out how many records are 
# in the shortest of the seasonal data files.

