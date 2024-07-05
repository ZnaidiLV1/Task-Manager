from django.db import models
from authentification.models import *

class Task(models.Model):
    email=models.ForeignKey(CustomUser,on_delete=models.CASCADE)
    date=models.CharField()
    time=models.CharField()
    task_to_do=models.CharField()
# Create your models here.
