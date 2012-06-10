#takes random sample of dataset, puts into other folder of holdout data

import os,glob,random,shutil

directory = 'images/data/herc-data/'
destDir =  'images/data/holdout/'
numHoldOut = 20
 
for label in ['integral','star','minus','plus','sigma']:
             #['seven','nine']:
             #['zero','four','eight']:
             #['one','two','three','five','six']:
             #['neg']:['forall','exist', 'neg', 'leftParen', 'rightParen',
             # 'x', 'y', 'z', 'ne', 'elem', 'and', 'or', 'ifThen', 'iff',
             # 'subset', 'F', 'R']:
  random.seed()
  filenames = glob.glob(directory+label+'/*.jpg')
  print label
  holdout = random.sample(filenames,numHoldOut)
  os.mkdir(destDir+label)

  for h in holdout:
    shutil.move(h,destDir+label)
     
