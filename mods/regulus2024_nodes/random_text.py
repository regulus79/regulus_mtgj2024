
import random

#alphabet = list("et sarolnimpucbykghjvdzfwqx")
consonants = list("tsrlnmpcbkghjvdzfwqx")
vowels = list("eaoiuy")
#print(consonants)
#print(vowels)
#print(sorted(consonants))
#print(sorted(vowels))
#print(len(set(consonants)))
#print(len(set(vowels)))

# what a Ziphy law! (I think)
distribution_consonants = []
for i,v in enumerate(consonants):
    distribution_consonants += [v,] * (len(consonants) // (i + 1))

distribution_vowels = []
for i,v in enumerate(vowels):
    distribution_vowels += [v,] * (len(vowels) // (i + 1))

#print(distribution_consonants)
#print(len(set(distribution_consonants)))
#print(distribution_vowels)
#print(len(set(distribution_vowels)))

def generate_word(length):
    text = ""
    for i in range(length//2):
        text += random.choice(distribution_consonants)
        text += random.choice(distribution_vowels)
    return text

def generate_text(num_words):
    text = []
    for i in range(num_words):
        word_length = int(1.5**(5 * random.random()) + random.randrange(1,3))
        endings = ["","","","", ",", "."]
        ending = random.choice(endings)
        word = generate_word(word_length) + ending
        if i > 0 and text[-1][-1] == ".":
            word = word[0].upper() + word[1:]
        text.append(word)
    final_text = " ".join(text)
    final_text = final_text[0].upper() + final_text[1:]
    return final_text

print(generate_text(30))
