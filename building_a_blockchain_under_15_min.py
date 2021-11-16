from hashlib import md5
from typing import List, Mapping

# demonstrating mutability
class testhash:
    def __init__(self):
        list1 = ('a','b', 'c')
        list2 = ('a', 'b', 'c')

        # only tuples can be hashed in python

        print(hash(list1))
        print(hash(list2))

# blockchain 
class Block:
    def __init__(self, previoushash, transaction):
        self.previoushash = previoushash
        # if isinstance(transaction, list):
        #     self.transaction = ":".join(transaction)
        # else:
        #     self.transaction = transaction

        # we are using join operator with the assumption that we will be using an array for transaction
        self.transaction = " : ".join(transaction).encode('utf-8')

        hash_of_string = md5(self.transaction)

        #print(type(hash_of_string), type(self.previoushash))

        hash_tuple = (hash_of_string.hexdigest() , self.previoushash)

        #print(type(hash_tuple))

        self.blockhash = hash(hash_tuple)

    def getPreviousHash(self):
        return self.previoushash
    
    def getTransaction(self):
        return self.transaction

    def getBlockHash(self):
        return self.blockhash

if __name__ == "__main__":
    genesisTransaction = {"Can ashwin amount ot anything.", "love is in the air", "Also sent ashwin 5 bitcoins"}
    genesisBlock = Block(previoushash=0, transaction=genesisTransaction)

    print(genesisBlock.getBlockHash())

    block1_transaction = {"Hallo", "topsoil", "love"}
    block1 = Block(previoushash=genesisBlock.getBlockHash(), transaction=block1_transaction)

    print(block1.getBlockHash())
