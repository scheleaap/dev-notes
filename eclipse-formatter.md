# Eclipse formatter

```bash
#!/bin/bash
eclipse -application org.eclipse.jdt.core.JavaCodeFormatter -config /home/<user>/ws/org.eclipse.jdt.core.prefs $@
```

`/home/<user>/ws/org.eclipse.jdt.core.prefs` is an exported formatter settings in .properties format
