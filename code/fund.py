#from openpyxl import Workbook
#from openpyxl import load_workbook
import numpy as np
import pandas as pd

def get_data(s):
    if type(s) == float:
        return s
    else:
        return s
        #tmp = s[:-1]
        #return float(tmp)

ws = pd.read_csv('input.csv',header = None, low_memory=False)


'''
print(type(ws.iloc[2,4]))
t = ws.iloc[2,4]
s = t[:-1]
g = float(s)
print(g)
print(type(g))
if ws.iloc[2,4] == -0.0084:
    print('fine')
'''
    
'''
print(ws.iloc[0,1])
print(ws.iloc[1550,0])
print(ws.iloc[1551,0])
print(ws.iloc[1552,0])
if isnull(ws.iloc[1550,0]):
    print('fine')
'''

rate_tot = np.zeros((790,1600))
rate_mean = np.zeros(790)
rate_std = np.zeros(790)
ISIN = []

for fund_id in range(0,10):
    ISIN.append(ws.iloc[0,fund_id*4+1])
    r_col = (fund_id + 1) * 4
    ws.iloc[0,r_col] = 'return rate'
    r_row = 2    #return rate date = r_row - 2
    
    while(True):
        if (pd.isnull(ws.iloc[r_row,r_col-1])):
             break
         
        v1 = get_data(ws.iloc[r_row-1,r_col-1])
        v2 = get_data(ws.iloc[r_row,r_col-1])
        #print("v1 = {0}".format(v1))
        #print("v2 = {0}".format(v2))
        
        return_tmp = float(v2/v1 - 1.00000000000)
        rate_tot[fund_id,r_row-2] = return_tmp
        ws.iloc[r_row,r_col] = return_tmp
        
        r_row = r_row + 1
        
    #average return rate
    avg_return_tmp = np.mean(rate_tot[fund_id,0:(r_row-2)])
    #print(rate_tot[fund_id,0:(r_row-2)])
    rate_mean[fund_id] = avg_return_tmp
    ws.iloc[r_row,r_col-1] = 'average = '
    ws.iloc[r_row,r_col] = avg_return_tmp
    
    
    #standard deviation 
    std_tmp = np.std(rate_tot[fund_id,0:(r_row-2)])
    rate_std[fund_id] = std_tmp
    ws.iloc[r_row+1,r_col-1] = 'std ='
    ws.iloc[r_row+1,r_col] = std_tmp
    
    #sort
    std_sorted = np.zeros((790,2))
    std_sorted[:,0] = np.argsort(rate_std)
    std_sorted[:,1] = np.sort(rate_std)
    std_out_2 = pd.DataFrame(std_sorted)
    std_out_2.to_csv('sorted_std.csv')

    
#ws.to_csv('output.csv')
mean_out = pd.DataFrame(rate_mean)
#print(mean_out)
mean_out.to_csv('mean.csv')

std_out = pd.DataFrame(rate_std)
#print(std_out)
std_out.to_csv('std.csv')

ISIN_out = pd.DataFrame(ISIN)
ISIN_out.to_csv('ISIN.csv')





    