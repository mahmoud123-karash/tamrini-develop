import 'package:dartz/dartz.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/gallery_model.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';

abstract class TrainerRepo {
  Future<Either<String, List<TrainerModel>>> get();
  Future<Either<String, List<TrainerModel>>> editTrainer({
    required TrainerModel trainer,
    required String description,
    required int price,
    required String fromH,
    required String toH,
  });
  Future<Either<String, List<TrainerModel>>> banTrainer({
    required String trainerId,
    required bool isBanned,
  });

  Future<Either<String, List<TrainerModel>>> updateGallery({
    required TrainerModel trainer,
    required String imgBefore,
    required String imgAfter,
  });

  Future<Either<String, List<TrainerModel>>> removeGallery({
    required TrainerModel trainer,
    required GalleryModel model,
  });

  Future<Either<String, List<TrainerModel>>> addNewQuestion({
    required TrainerModel trainer,
    required String question,
  });

  Future<Either<String, List<TrainerModel>>> removeQuestion({
    required TrainerModel trainer,
    required String question,
  });
}
