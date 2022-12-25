PHONY: test
test:
	-robot --include flasky tests/robot/src/tests/ui/ui_test_page.robot
	-python -m pytest tests/pytest/src/tests/flasky/

PHONY: pytest
pytest:
	-python -m pytest tests/pytest/src/tests/flasky/

PHONY: robot
robot:
	-robot tests/robot/src/tests/ui/