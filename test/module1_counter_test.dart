import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:logbook_app_081/counter_controller.dart';

void main() {
  group('Module 1 - CounterController', () {
    late CounterController controller;

    setUp(() {
      controller = CounterController();
    });

    // TC01: initial value should be 0
    // Prekondisi: CounterController telah dibuat
    // Langkah Pengujian:
    //   (1) setup (arrange, build): Buat instance CounterController baru
    //   (2) exercise (act, operate): -
    //   (3) verify (assert, check): Periksa nilai counter
    // Data Test: -
    // Ekspektasi: counter.value == 0
    test('initial value should be 0', () {
      expect(controller.value, 0);
    });

    // TC02: setStep should change step value
    // Prekondisi: CounterController telah dibuat dengan step default = 1
    // Langkah Pengujian:
    //   (1) setup (arrange, build): Inisialisasi controller
    //   (2) exercise (act, operate): Panggil setStep(5)
    //   (3) verify (assert, check): Periksa nilai currentStep
    // Data Test: newStep = 5
    // Ekspektasi: currentStep == 5
    test('setStep should change step value', () {
      controller.setStep(5);
      expect(controller.currentStep, 5);
    });

    // TC03: setStep should ignore negative value
    // Prekondisi: CounterController dengan step = 1
    // Langkah Pengujian:
    //   (1) setup (arrange, build): Panggil setStep(5)
    //   (2) exercise (act, operate): Panggil setStep(-1)
    //   (3) verify (assert, check): Periksa nilai currentStep
    // Data Test: step1 = 5, step2 = -1
    // Ekspektasi: currentStep tetap 5 (negative value diabaikan)
    test('setStep should ignore negative value', () {
      controller.setStep(5);
      controller.setStep(-1);
      expect(controller.currentStep, 5);
    });


    // TC04: decrementCounter should decrease counter based on step
    // Prekondisi: CounterController dengan value = 0
    // Langkah Pengujian:
    //   (1) setup (arrange, build): Set step = 2, panggil incrementCounter()
    //   (2) exercise (act, operate): Panggil decrementCounter()
    //   (3) verify (assert, check): Periksa nilai counter
    // Data Test: step = 2
    // Ekspektasi: counter.value == 0
    test('decrementCounter should decrease counter based on step', () {
      controller.setStep(2);
      controller.incrementCounter();
      controller.decrementCounter();
      expect(controller.value, 0);
    });

    // TC05: decrementCounter should not go below zero when step > value
    // Prekondisi: CounterController dengan value = 0
    // Langkah Pengujian:
    //   (1) setup (arrange, build): Set step = 4, incrementCounter(), set step = 5
    //   (2) exercise (act, operate): Panggil decrementCounter()
    //   (3) verify (assert, check): Periksa nilai counter
    // Data Test: step1 = 4, step2 = 5
    // Ekspektasi: counter.value == 0 (tidak boleh negatif)
    test('decrementCounter should not go below zero when step > value', () {
      controller.setStep(4);
      controller.incrementCounter();
      controller.setStep(5);
      controller.decrementCounter();
      expect(controller.value, 0);
    });

    // TC06: incrementCounter should increase counter based on step
    // Prekondisi: CounterController dengan value = 0
    // Langkah Pengujian:
    //   (1) setup (arrange, build): Set step = 2
    //   (2) exercise (act, operate): Panggil incrementCounter()
    //   (3) verify (assert, check): Periksa nilai counter
    // Data Test: step = 2
    // Ekspektasi: counter.value == 2
    test('incrementCounter should increase counter based on step', () {
      controller.setStep(2);
      controller.incrementCounter();
      expect(controller.value, 2);
    });

    // TC07: resetCounter should set counter to zero
    // Prekondisi: CounterController dengan value = 0
    // Langkah Pengujian:
    //   (1) setup (arrange, build): Set step = 3, incrementCounter()
    //   (2) exercise (act, operate): Panggil resetCounter()
    //   (3) verify (assert, check): Periksa nilai counter
    // Data Test: step = 3
    // Ekspektasi: counter.value == 0
    test('resetCounter should set counter to zero', () {
      controller.setStep(3);
      controller.incrementCounter();
      controller.resetCounter();
      expect(controller.value, 0);
    });

    // TC08: currentHistory should record actions in newest-first order
    // Prekondisi: CounterController dengan history kosong
    // Langkah Pengujian:
    //   (1) setup (arrange, build): Set step = 1
    //   (2) exercise (act, operate): Panggil incrementCounter(), decrementCounter()
    //   (3) verify (assert, check): Periksa history tidak kosong, length = 2, entry pertama 'Mengurangi', terakhir 'Menambahkan'
    // Data Test: step = 1, actions = increment, decrement
    // Ekspektasi: history.length == 2, first.contains('Mengurangi'), last.contains('Menambahkan')
    test('currentHistory should record actions in newest-first order', () {
      controller.setStep(1);
      controller.incrementCounter();
      controller.decrementCounter();

      expect(controller.currentHistory, isNotEmpty);
      expect(controller.currentHistory.length, 2);
      expect(controller.currentHistory.first.contains('Mengurangi'), true);
      expect(controller.currentHistory.last.contains('Menambahkan'), true);
    });

    // TC09: history should only keep 5 latest items
    // Prekondisi: CounterController dengan history kosong
    // Langkah Pengujian:
    //   (1) setup (arrange, build): Set step = 1
    //   (2) exercise (act, operate): Loop incrementCounter() 6 kali
    //   (3) verify (assert, check): Periksa history length, entry pertama 'dari 5 ke 6', terakhir 'dari 1 ke 2'
    // Data Test: step = 1, iterations = 6
    // Ekspektasi: history.length == 5, first.contains('dari 5 ke 6'), last.contains('dari 1 ke 2')
    test('history should only keep 5 latest items', () {
      controller.setStep(1);

      for (int i = 0; i < 6; i++) {
        controller.incrementCounter();
      }

      expect(controller.currentHistory.length, 5);
      expect(controller.currentHistory.first.contains('dari 5 ke 6'), true);
      expect(controller.currentHistory.last.contains('dari 1 ke 2'), true);
    });

    // TC10: colorTile should return green for Menambahkan action
    // Prekondisi: CounterController telah dibuat
    // Langkah Pengujian:
    //   (1) setup (arrange, build): Siapkan text dengan 'Menambahkan'
    //   (2) exercise (act, operate): Panggil colorTile()
    //   (3) verify (assert, check): Periksa warna yang dikembalikan
    // Data Test: text = 'User Menambahkan dari 0 ke 1'
    // Ekspektasi: color == Colors.green
    test('colorTile should return green for Menambahkan action', () {
      expect(controller.colorTile('User Menambahkan dari 0 ke 1'), Colors.green);
    });
  });
}
