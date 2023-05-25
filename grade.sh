CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area
rm results.txt

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

cp student-submission/ListExamples.java ./

javac -cp $CPATH *.java
if [ $? -ne 0 ] 
then
    echo 'Failed to compile'
    echo "Grade is 0%"
    exit 1
fi
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > results.txt
if [ $? -ne 0 ] 
then
    echo 'Failed to run tests'
fi

failures=$(grep "Failures:" results.txt | awk -F': ' '{print $3}')
tests=$(grep "Tests run:" results.txt | awk -F': ' '{print $2}' | awk -F', ' '{print $1}')
echo ""
echo "Failures: $failures" 
echo "Tests run: $tests"
grade=$(echo "scale=2; ($tests - $failures) / $tests * 100" | bc)
echo "grade is $grade%"

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

