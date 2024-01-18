# Skin Problem Detection

## Introduction

This projects is to build prediction model that can classify 6 classes about skin problem such as 'Acne', 'Blackhead', 'Dark Circles', 'Dry Skin', 'Englarged Pores', and, 'Wrinkles'. To attain the result this project used the latest mode of YOLO version 8 with **yolov8n.pt** as an official model from ultralytics.

## Dataset

The dataset used in this project is from [ROBOFLOW](https://universe.roboflow.com/augment-gkvan/skin-problems-detection/dataset/9). 

## Model

The model used in this project is YOLOv8. The model is trained with 3 epochs and the result is shown below.

* Before Detection:

![before detection image](./predict_image/image1.jpg)

* After Detection:

![after detection image](./runs/detect/train25/image1.jpg)

## License

The MIT License (MIT)

Copyright (c) 2023 Adrian Glazer

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.