# Pandas

Display all rows: `with pd.option_context("display.max_rows", None)`
## Visualization with Plotly

General, center title: `.update_layout(title_x=0.5)`
General, remove legend title: `.update_layout(legend_title=None)`
General, set x/y axis title: `.update_layout(xaxis_title="Foo", yaxis_title="Bar")`
General, set series name: use `df.rename({...})`

Histogram, one bar per day: `.update_traces(xbins=dict(size="D1"))`
Histogram, set bar size: `.update_traces(xbins=dict(start=0, size=10))`
