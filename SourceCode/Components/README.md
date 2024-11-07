1. Get ElementPhase.csv first from the CST software for your element design (look at the sample I have provided)
2. Run PhaseDistribution.m 
(output:PhaseDistribution.csv,Coordinates.csv, ElementNum.csv)
3. Run Mapping.m (input:ElementPhase.csv input:PhaseDistribution) (output: ElementDim.csv)
4. Run ScriptAutomator.m (input: ElementDim.csv, Coordinates.csv, ElementNum.csv)
5. Final Output: Reflectarrayscript.scr (For CAD Drawing which can be exported to CST)