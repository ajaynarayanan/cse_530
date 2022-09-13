import random
import pdb
import argparse
import os
import math
import numpy as np
from scipy import sparse

parser = argparse.ArgumentParser(description='Input Matrix generator')
parser.add_argument('--seed', type=int, default=0, help='Seed Value')
parser.add_argument('--n', type=int, default=3, help='Number of columns in the matrix')
parser.add_argument('--m', type=int, default=3, help='Number of rows in the matrix')
parser.add_argument('--sparsity', type=int, default=0, help='Sparisty of matrix in %')
parser.add_argument('--dump', type=str, default='input_matrix.in', help='File name')
parser.add_argument('--numOfMatrices', type=int, default=1, help='Number of matrices to generate')


def createRandomMatrix(m, n):
    maxVal = 1000  # I don't want to get Java / C++ into trouble
    matrix = []
    for i in range(m):
        matrix.append([random.randint(0, maxVal) for el in range(n)])
    return matrix


def saveMatrix(list_of_matrices, filename):
    if os.path.exists(filename): 
        os.remove(filename)
    else:   
        print("New file created: ",filename)
    f = open(filename, "w")
    for i, matrix in enumerate(list_of_matrices):
        if i != 0:
            f.write("\n")
        for line in matrix:
            #pdb.set_trace()
            f.write("\t".join(map(str, line)) + "\n")


def saveCSRMatrix(CSR_matrix, filename):
    if os.path.exists(filename): 
        os.remove(filename)
    else:   
        print("New file created: ",filename)

    f = open(filename,"w")
    f.write(f"{args.m}, {args.n}")
    f.write("\n")
    for row, col in zip(*CSR_matrix.nonzero()):
        val = CSR_matrix[row,col]
        f.write("Row: "+str(row)+", Col: ")
        f.write(str(col)+", ")
        f.write("Val: "+str(val)+".")
        f.write("\n")
    f.close()

def addSparsity(matrixA, m, n, sparsity):
    """
    Adds sparsity to the given matrix
    """
    #Replace random x %element to 0 in matrixA
    matrixA = np.asarray(matrixA)
    indicesA = np.random.choice(np.arange(matrixA.size), replace=False,
                        size=int(matrixA.size * (sparsity/100)))
    flatA  = matrixA.flatten()
    flatA[indicesA] = 0

    #Reshape it back to original shape
    flatA = flatA.reshape(m,n)
    #print(flatA)
    matrixA_csr = sparse.csr_matrix(flatA)
    #print(matrixA_csr)
    matrixA = flatA.tolist()

    return matrixA, matrixA_csr

def main():
    global args
    args = parser.parse_args()
    print(40*"="+"\nArgs:{}\n".format(args)+40*"=")
    random.seed(args.seed)
    m = args.m
    n = args.n
    outpath = args.dump
    list_of_matrices = []

    for index in range(args.numOfMatrices):
        #Create dense matrix
        matrixA = createRandomMatrix(m, n)
        #Convert to sparse matrix by replacing value below threshold to 0
        if (args.sparsity):
            # add sparsity
            matrixA, matrixA_csr = addSparsity(matrixA, m, n, args.sparsity)        
            # save the matrix
            csr_Amatrix = f"csr_{index}_{args.dump}"
            saveCSRMatrix(matrixA_csr, csr_Amatrix)
        list_of_matrices.append(matrixA)

    # save all matrics
    saveMatrix(list_of_matrices, args.dump)
    

if __name__ == '__main__':
    main()
