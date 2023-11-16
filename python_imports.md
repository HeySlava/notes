```python
import pkgutil
import pkg

# https://www.youtube.com/watch?v=t43zBsVcva0
for _, name, _ in pkgutil.walk_packages(pkg.__path__, f'{pkg.__name__}.'):
    print(f'importing {name}...')
    # python3 -m pydoc __import__
    __import__(name, fromlist=['_trash'])
```
