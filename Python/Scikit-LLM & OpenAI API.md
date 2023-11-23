---
sort: 5
---

# Scikit-LLM & OpenAI API

We take advantages of the Anaconda module.

## Installation

```bash
module load ceuadmin/Anaconda3/2023.09-0
pip install scikit-llm watermark
pip install openai langchain pypdf unstructured "unstructured[pdf]"
```

## Configuration

Web for the keys: <https://platform.openai.com/account/api-keys> & <https://platform.openai.com/account/org-settings>

```python
importing SKLLMConfig to configure OpenAI API (key and Name)
from skllm.config import SKLLMConfig
OPENAI_API_KEY = "sk-*"
OPENAI_ORG_ID = "org-*"
# Set your OpenAI API key
SKLLMConfig.set_openai_key(OPENAI_API_KEY )
# Set your OpenAI organization
SKLLMConfig.set_openai_org(OPENAI_ORG_ID)
```

## Implementation

(To be refined)

```python

# Zero-Shot GPTClassifier

# importing zeroshotgptclassifier module and classification dataset
from skllm import ZeroShotGPTClassifier
from skllm.datasets import get_classification_dataset
# sentiment analysis dataset
# labels: positive, negative, neutral
X, y = get_classification_dataset()
len(X)
X
y
# to notice: indexing starts at 0
def training_data(data):
    subset_1 = data[:8]  # First 8 elements from 1-10
    subset_2 = data[10:18]  # First 8 elements from 11-20
    subset_3 = data[20:28]  # First 8 elements from rest of the data
    combined_data = subset_1 + subset_2 + subset_3
    return combined_data
# to notice: indexing starts at 0
def testing_data(data):
    subset_1 = data[8:10]  # Last 2 elements from 1-10
    subset_2 = data[18:20]  # Last 2 elements from 11-20
    subset_3 = data[28:30]  # Last 2 elements from rest of the data
    combined_data = subset_1 + subset_2 + subset_3
    return combined_data
X_train = training_data(X)
print(len(X_train))
X_train
y_train = training_data(y)
print(len(y_train))
y_train
# defining the openai model to use
clf = ZeroShotGPTClassifier(openai_model="gpt-3.5-turbo")
# fitting the data
clf.fit(X_train, y_train)
# predicting the data
predicted_labels = clf.predict(X_test)
for review, sentiment in zip(X_test, predicted_labels):
    print(f"Review: {review}\nPredicted Sentiment: {sentiment}\n\n")
from sklearn.metrics import accuracy_score
print(f"Accuracy: {accuracy_score(y_test, predicted_labels):.2f}")

# No Labeled Data

# defining the model
clf_no_label = ZeroShotGPTClassifier()
# No training so passing the labels only for prediction
clf_no_label.fit(None, ['positive', 'negative', 'neutral'])
# predicting the labels
predicted_labels_without_training_data = clf_no_label.predict(X_test)
predicted_labels_without_training_data
for review, sentiment in zip(X_test, predicted_labels_without_
training_data):
    print(f"Review: {review}\nPredicted Sentiment: {sentiment}\n\n")
print(f"Accuracy: {accuracy_score(y_test, predicted_labels_without_
training_data):.2f}")

# Multilabel Zero-Shot Text Classification

# importing Multi-Label zeroshot module and classification
from skllm import MultiLabelZeroShotGPTClassifier
from skllm.datasets import get_multilabel_classification
# get classification dataset from sklearn
X, y = get_multilabel_classification_dataset()
# defining the model
clf = MultiLabelZeroShotGPTClassifier(max_labels=3)
# fitting the model
clf.fit(X, y)
# making predictions
labels = clf.predict(X)

# No Labeled Data

# getting classification dataset for prediction only
from skllm.datasets import get_multilabel_classification_dataset
from skllm import MultiLabelZeroShotGPTClassifier
X, _ = get_multilabel_classification_dataset()
# Defining all the labels that need to be predicted
candidate_labels = [
    "Quality",
    "Price",
    "Delivery",
    "Service",
    "Product Variety"
]
# creating the model
clf = MultiLabelZeroShotGPTClassifier(max_labels=3)
# fitting the labels only
clf.fit(None, [candidate_labels])
# predicting the data
labels = clf.predict(X)

# Text Vectorization

# Importing the GPTVectorizer class from the skllm.preprocessing module
from skllm.preprocessing import GPTVectorizer
# Creating an instance of the GPTVectorizer class and assigning it to the 
variable 'model'
model = GPTVectorizer()
# transforming the
vectors = model.fit_transform(X)
# Importing the necessary modules and classes
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import LabelEncoder
from xgboost import XGBClassifier
# Creating an instance of LabelEncoder class
le = LabelEncoder()
# Encoding the training labels 'y_train' using LabelEncoder
y_train_encoded = le.fit_transform(y_train)
# Encoding the test labels 'y_test' using LabelEncoder
y_test_encoded = le.transform(y_test)
# Defining the steps of the pipeline as a list of tuples
steps = [('GPT', GPTVectorizer()), ('Clf', XGBClassifier())]
# Creating a pipeline with the defined steps
clf = Pipeline(steps)
# Fitting the pipeline on the training data 'X_train' and the encoded 
training labels 'y_train_encoded'
clf.fit(X_train, y_train_encoded)
# Predicting the labels for the test data 'X_test' using the trained 
pipeline
yh = clf.predict(X_test)

# Text Summarization

# Importing the GPTSummarizer class from the skllm.preprocessing module
from skllm.preprocessing import GPTSummarizer
# Importing the get_summarization_dataset function
from skllm.datasets import get_summarization_dataset
# Calling the get_summarization_dataset function
X = get_summarization_dataset()
# Creating an instance of the GPTSummarizer
s = GPTSummarizer(openai_model='gpt-3.5-turbo', max_words=15)
# Applying the fit_transform method of the GPTSummarizer instance to the 
input data 'X'.
# It fits the model to the data and generates the summaries, which are 
assigned to the variable 'summaries'
summaries = s.fit_transform(X)
```

## Reference

Kulkarni A, Shivananda A, Kulkarni A, Gudivada D (2023). Applied Generative AI for Beginners. Apress, Berkeley, CA. <https://link.springer.com/book/10.1007/978-1-4842-9994-4> ([Amazon](https://www.amazon.co.uk/gp/reader/1484299930/?tag=ebookshare-21))
