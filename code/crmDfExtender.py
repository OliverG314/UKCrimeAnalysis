import pandas as pd
import numpy  as np

df = pd.read_csv("../data/20152024regionalcrime.csv")

popDf = pd.read_csv("../data/regionalpopulation.csv")
kmsDf = pd.read_csv("../data/mlnkmsbytype.csv")

popYears = range(2011, 2024)

areas = df["Area name"].unique()

count = 0

pfaPop = np.zeros(len(df)).tolist()

pfaCarKms = np.zeros(len(df)).tolist()
pfaLcvKms = np.zeros(len(df)).tolist()
pfaHgvKms = np.zeros(len(df)).tolist()

for i in df.iloc:
    year = i["Year ending September"]
    area = i["Area name"]

    if year in popYears:
        popData = sum(popDf["Mid-" + str(year)].loc[popDf["PFA"] == area].tolist())

        carKmsData = sum(kmsDf[str(year)].loc[(kmsDf["PFA"] == area) & (kmsDf["Vehicle"] == "Cars and Taxis")].dropna().astype(float).tolist())
        lcvKmsData = sum(kmsDf[str(year)].loc[(kmsDf["PFA"] == area) & (kmsDf["Vehicle"] == "Light Commercial Vehicles")].dropna().astype(float).tolist())
        hgvKmsData = sum(kmsDf[str(year)].loc[(kmsDf["PFA"] == area) & (kmsDf["Vehicle"] == "Heavy Goods Vehicles")].dropna().astype(float).tolist())

    else:
        popData = None

        carKmsData = None
        lcvKmsData = None
        hgvKmsData = None

    pfaPop[count] = popData
    
    pfaCarKms[count] = carKmsData
    pfaLcvKms[count] = lcvKmsData
    pfaHgvKms[count] = hgvKmsData

    count += 1

df["Population mid-year estim"] = pfaPop
df["Million kms by car/taxi"] = pfaCarKms
df["Million kms by lcvs"] = pfaLcvKms
df["Million kms by hgvs"] = pfaHgvKms

pfaKms = np.zeros(len(df)).tolist()

df.to_csv("../data/20152024regionalcrimeFull.csv")
