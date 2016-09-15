#!/bin/bash

echo "Current user:"
id
echo "Executing jenkins-slave..."
jenkins-slave $@
