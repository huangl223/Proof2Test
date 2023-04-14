Proof2Test is a tool that automatically generates tests from failed proofs in [AutoProof](http://autoproof.sit.org).
The generated tests can be executed in [AutoTest](http://se.inf.ethz.ch/research/autotest).


**Steps of using Proof2Test (Win):**

1. Download the executable file (proof2test.exe) in the `executable` folder.

2. Add the path of proof2test.exe to the environment variable `PATH`

3. Obtain two input files, generated from failed proofs in AutoProof:
- boogie program (.bpl file) 
- the counterexample model  (.model)

4. Open Command Line Interface, go to the directory of the input files, and use the following command for test generation: 

`proof2test -b bpl_file -m model_file`

- `bpl_file`: the name of the boogie program (.bpl)
- `model_file`: the name of the counterexample model  (.model) 

Example: 

   `proof2test -b autoproof.bpl -m ce.model`


For more information, see the Proof2Test Tutorial.pdf





