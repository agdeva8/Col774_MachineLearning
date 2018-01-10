####### this is simple multi-variate Bernoulli event model

#### importing the required modules
import random
import numpy as np
import pickle                     ### to store the list in drive for future use
from collections import Counter   ### calculating the frequency of element in list
import itertools                  ### for permutations
f = open('/home/deva/Documents/machineLearning_Col774/assignment 3/q2/newSet.txt')
fullArticle = f.read()
f.close()

fullArticle = fullArticle.replace('\t',' ')

articleList = fullArticle.split('\n')
### removing the empty article 
articleList.remove('')

temp = []
for article in articleList:
    temp.append(article.split(' '))

articleList = temp

### shuffling the articleList to randomise the split
articleList = random.sample(articleList,len(articleList))

print 'created article list and done shuffling too'

### splitting the articleList in 5 equal parts 
lenAL = len(articleList)
increment = lenAL/5
last = 0
i = 0
articleChunk = []
while last < lenAL:
    articleChunk.append(articleList[last:(last+increment)])
    i = i+1
    last = last+increment

print 'created article chunk'

#### creating the training list which has four articles....
trainingList = []
permute = list(itertools.permutations(range(5)))
for cbn in permute:
	trainingList += articleChunk[cbn[0]]+articleChunk[cbn[1]]+articleChunk[cbn[2]]+articleChunk[cbn[3]]

	print 'created training list'

	#### creating the dictionary 
	articleWords = []
	for i in range(len(trainingList)):	
	    articleWords += trainingList[i]

	articleDict = list(set(articleWords))

	print 'created dictionary'

	## creating the list of different newspapers
	newspaperList = []
	for word in articleDict:
	    if 'rec.' in word or 'talk.' in word:
	        newspaperList.append(word)

	print 'created list of all newspapers'

	## removing the rec. and talk. from artileWords and dict
	for word in newspaperList:
	    articleWords.remove(word)
	    articleDict.remove(word)

	############ finding the most common words articleWords 
	counts = Counter(articleWords).most_common()

	###### creating the new dict of only first 1000 frequent words
	newDict = []
	for i in range(5000):
	    newDict.append(counts[i][0])

	m = len(trainingList)
	n = len(newDict)
	k = len(newspaperList)

	print 'created new dict '

	sumYphi = np.zeros(k)
	sumY = np.zeros(k)
	phi = np.ones((k,n))

	for article in trainingList:
		rIdx = newspaperList.index(article[0])
		sumY[rIdx] +=1
		for word in article:
			if word in newDict:
				sumYphi[rIdx] += 1
				cIdx = newDict.index(word)
				phi[rIdx][cIdx] += 1  

	print 'phi created'

	### summing all the columns of y to comupte sum(I{y=i})
	#sumY = np.sum(y,axis = 1)
	sumYphi =[element+n for element in sumYphi]

	for i in range(len(phi)):
	    phi[i] = phi[i]/sumYphi[i]

	print 'starting prediction'
	#### pridicting the article type ..
	### i will not calculate p(y=i|x) exactly as we need to do only comparision.
	total_correct = 0
	for article in articleChunk[cbn[4]]:
	    pxY = list(sumY)
	    for word in article:
	        if word in newDict:
	            idx = newDict.index(word)
	            pxY = pxY*phi[:,idx]
	    pxY = list(pxY)
	    
	    predictedArticle = newspaperList[pxY.index(max(pxY))]
	    if predictedArticle == article[0]:
	        total_correct += 1

	percent_correct = float(total_correct)/float(len(articleChunk[4]))*100
	print 'percent_correct'
	print percent_correct