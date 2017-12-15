# goswagger-multiplefiles
This repo demonstrates the behavior of generating code from a swagger spec, and outlines the "special" behavior that go-swagger exhibits in each case.

## *Working Case:* referencing model into definitions from external file
This code works: 
`make catfilename`
This sample refereces a `Cat` definition from `definitions` section of a root file when `Cat`'s properties are actually declared inside `cat.yaml` file. Not the definition itself but properties only.

## *Working Case:* referencing model with multi-word name into definitions from external file
This code works: 
`make cheshiresfilename`
This sample refereces a `CheshireCat` definition from `definitions` section of a root file when `CheshireCat`'s properties are actually declared inside `cheshire_cat.yaml` file. Again withot proper definition.

## *Broken Case:* referencing model in external File
This code should work:
`make externalpet`
This sample references a `Pet` definition from a different file (`pets.yml`) and renders a `Pet` model as expected (see `output/models/pet.go`)

output/models/pet.go file contains the following definition: 
`type Pet struct {
    Pet // this is a cyclic self-embedding. This is weird.
}`

## *Broken Case:* referencing nested model in external file
`make externalpets`
This sample references a `Pets` definition from a different file (`pets.yml`) which in turn references a `Pet` definition. In this case, no `Pet` model is generated.

## *Broken Case:* referencing a file via url with local references
`make urlpets`
This sample references a `Pet` definition from a file via a url, which in turn references a definition locally relative to its location (`NewPet`). This returns an error while trying to build:
`error in model pet while planning definitions: could not generate schema for pet: object has no key "NewPet"`


## Conclusion: Be careful using external files
Generally, I think there are two issues:
* go-swagger won't build a representation for anything that's not under the `definitions` section, so it'll silently fail if you're referencing a definition that isn't in turn declared in `definitions`
* go-swagger doesn't interpret the json pointer syntax correctly and instead of resolving based on the context of the local file, it resolves based on the location that the command was run (or the location of the source swagger config file, I'm not sure which)

It's best not to rely on the behavior of go-swagger in regard to external files at this point. Other options would be to find a tool that can dereference and compile a single swagger file from multiple files, then pass that generated spec into go-swagger for code generation purposes. I haven't yet looking into this solution, but think it's the next best step. The other option, of course, is to contribute to the go-swagger codebase and fix the broken behavior.
