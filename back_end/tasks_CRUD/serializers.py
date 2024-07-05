from rest_framework import serializers
from .models import *

class task_serializer(serializers.ModelSerializer):
    class Meta:
        model=Task
        fields='__all__'