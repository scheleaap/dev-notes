# Documenting decisions

Decisions are documented in decision records.

The general structure for decision records should be like this:

```md
# <Title>

## Background

_Give the background knowledge and context needed to understand the decision._

## Glossary

_Optional section. Not needed most of the time, but can sometimes be useful._

## Problem / Question

_Describe the problem that needs a solution or the question that needs an answer. It's important that the description can be understood based on the background knowledge and context given in the previous section (i.e. that it does not refer to concepts not defined in the document). If there is more than one problem / question, list them in a structured way. Choose "Problem" or "Question" as title._

## Alternatives

_Optional section. Describe the alternatives that were considered. If the alternatives are self-explanatory, this section may be folded into the "Evaluation" section._

### Rejected alternatives

_Optional section. If there were alternatives that were rejected early on, list them here, with the main reason for rejecting them. Be brief._

## Evaluation criteria

_Optional section. Describe the criteria against which the alternatives were evaluated. Criteria can have weights. If the criteria are self-explanatory, this section may be folded into the "Evaluation" section._

## Evaluation

_Compare the alternatives against the evaluation criteria. The most obvious and generally easy to read form is a table: evaluation criteria on the vertical axis, alternatives on the horizontal axis._

_Guidelines for tables: Avoid a lot of text, because this makes it hard to read. Avoid prose. Use ratings (e.g. easy/medium/hard, low/medium/high, ⭐/⭐⭐/⭐⭐⭐) with a few keywords on the next line. Use ✅/❌ to indicate fulfillment.

## Decision

_State the selected alternative, followed by a concise motivation._

Decided on <date (if known)> by <deciders (if known)>.
```

You may adapt the structure if the situation requires it: for example, if the document contains two questions that each need a decision, then each decision may be placed in its own section, each with the Alternatives / Evaluation criteria / Evaluation / Decision subsections.
