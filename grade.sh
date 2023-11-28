CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
if [[ -f student-submission/ListExamples.java ]]
then
    echo "Submitted correctly!"
else 
    echo "Submitted incorrectly, please resubmit."
    exit 1
fi
#copies all the necessary directories into grading-area
cp student-submission/ListExamples.java  grading-area
cp TestListExamples.java grading-area
cp -r lib grading-area

#cd into grading-area
cd grading-area

#compiles all the paths containing .java (that is what the * does) and redirects the error into error.txt
javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java 2> error.txt

#this checks the previous exit code, and any non-zero is an error code.
if [[ $? -ne 0 ]]
then
    echo "There was a compilation error"
    exit 1
fi 

#compiles the TestList.Examples with JUnitCore
java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > test.txt

GREP=`grep 'Failures: ' test.txt`

echo $GREP

if [[ $GREP -ne "" ]] 
then 
    echo "0%"
else 
    echo "100%"
fi