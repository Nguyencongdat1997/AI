"Load data"
#*note: Data description has been described in data folder
data_frame <- read.csv('E:/environment/git/AI/ML/Data/Loan Data of Dreaming Housing Finance/train.csv', header = TRUE)

"Check data information"
#View some samples
head(data_frame, 3)

#View basic figure about each Variables
library(psych) #import 'psych' library to use function 'decribe' below
describe(data_frame, na.rm = FALSE)
#*note: to download and install libraries, take 'psych' for example:  install.packages("psych",dependencies=TRUE)
#*C:\Users\DatGatto\AppData\Local\Temp\Rtmpe6Rxi7\downloaded_packages

#View posible Values of each Variables, check the number of null instances in each Variables
summary(data_frame)
#*note: Some resulted details:
#   - Gender 13 null, Married 3 null, Self_Employed 32 null, LoanAmount 22NA, Credit_History 50NA
#   - Gender Male(489) >> Female(112), Married Yes(493) > No(213), Self_Employed No(500) >> Yes(82)

#View distribution in some Variables:
#hist(train_data_frame$ApplicantIncome, col = rainbow(3))
#plot(train_data_frame$Loan_Status ~ train_data_frame$LoanAmount + train_data_frame$Gender + train_data_frame$Education)

'Data preparation'
data_preparation <- function(data_frame) {
    #Replace null values
    data_frame$LoanAmount[is.na(data_frame$LoanAmount)] = mean(data_frame$LoanAmount, na.rm = T)
    data_frame$Loan_Amount_Term[is.na(data_frame$Loan_Amount_Term)] = mean(data_frame$Loan_Amount_Term, na.rm = T)
    data_frame$Self_Employed <- replace(data_frame$Self_Employed, data_frame$Self_Employed == '', 'No') #because Self_Employed has 32 null values and they are inputed as ''
    data_frame$Married <- replace(data_frame$Married, data_frame$Married == '', 'Yes')
    data_frame$Gender <- replace(data_frame$Gender, data_frame$Gender == '', 'Male')
    data_frame$Credit_History[is.na(data_frame$Credit_History)] = 1.0

    #Convert our categorical variables into numeric by encoding the categories
    #*note: another solution is using CatEncoders.transform ,more detail of CatEncoders here: https://cran.r-project.org/web/packages/CatEncoders/CatEncoders.pdf
    y <- factor(data_frame$Gender)
    data_frame$Gender = as.numeric(y)
    y <- factor(data_frame$Married)
    data_frame$Married = as.numeric(y)
    y <- factor(data_frame$Education)
    data_frame$Education = as.numeric(y)
    y <- factor(data_frame$Self_Employed)
    data_frame$Self_Employed = as.numeric(y)
    y <- factor(data_frame$Property_Area)
    data_frame$Property_Area = as.numeric(y)
    y <- factor(data_frame$Loan_Status)
    data_frame$Loan_Status = as.integer(y)-1

    #Rescale some vairables
    data_frame$LoanAmount_log = log2(data_frame$LoanAmount)
    data_frame$TotalAmount = data_frame$ApplicantIncome + data_frame$CoapplicantIncome
    data_frame$TotalAmount_log = log2(data_frame$TotalAmount)

    return(data_frame)
}
processed_data_frame <- data_preparation(data_frame)

"Recheck the correlation between independent variables"
library(corrplot)
drops <- c("Loan_ID", "Dependents") #remove Variables that we donot want to check
droped_data_frame = processed_data_frame[, !(names(processed_data_frame) %in% drops)]
o = corrplot(cor(droped_data_frame), method = 'number') # this method can be changed try using method=’circle’

"Train"
library(caret)
library(rpart)
modelfit <- function(model,data_frame, predictor_variables, outcome_variable) {
    x_train <- data_frame[, (names(data_frame) %in% predictor_variables)]
    y_train <- data_frame[, (names(data_frame) %in% outcome_variable)]
    x <- cbind(x_train, y_train)

    train_control <- trainControl(method = "cv", number = 10, savePredictions = TRUE)
    model_with_kfolds <- train(y_train ~ ., data = x, trControl = train_control, method = model)
    model_with_kfolds$pred

}

predictor_variables <- c("Married", "Education", "Credit_History", "TotalIncome_log")
outcome_variable <- c("Loan_Status")
model <- 'rf'
modelfit(model,processed_data_frame,predictor_variables,outcome_variable)

