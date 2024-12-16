//
//  structs.swift
//  TrainTrackPro
//
//  Created by pc on 07.11.24.
//

import Foundation

class ExerciseManager {
    
    // MARK: - Exercises
    
    // Warm-Up Exercises
    
    let armCircles = Exercise(
        name: "Arm Circles",
        description: "Rotate your arms in circles to warm up shoulder joints.",
        adjustments: """
        Beginner: Perform movements slowly with smaller ranges of motion.
        Advanced: Increase speed and range of motion.
        """,
        duration: 60
    )
    
    let legSwings = Exercise(
        name: "Leg Swings",
        description: "Swing your legs to loosen hip joints.",
        adjustments: """
        Beginner: Hold onto a support for balance.
        Advanced: Increase swing height and speed.
        """,
        repetitions: 15
    )
    
    let hipCircles = Exercise(
        name: "Hip Circles",
        description: "Rotate your hips in circles to warm up hip joints.",
        adjustments: """
        Beginner: Perform smaller circles.
        Advanced: Increase circle size and speed.
        """,
        duration: 60
    )
    
    let torsoTwists = Exercise(
        name: "Torso Twists",
        description: "Twist your torso side to side to warm up core muscles.",
        adjustments: """
        Beginner: Twist gently.
        Advanced: Increase speed or add light weight.
        """,
        duration: 60
    )
    
    // Strength Training Exercises
    
    let bodyweightSquats = Exercise(
        name: "Bodyweight Squats",
        description: "Squat down and up using your body weight.",
        adjustments: """
        Beginner: Reduce depth or hold onto support.
        Advanced: Add weight or increase reps.
        """,
        repetitions: 12
    )
    
    let pushUps = Exercise(
        name: "Push-Ups",
        description: "Perform push-ups to strengthen chest and triceps.",
        adjustments: """
        Beginner: Perform on knees.
        Advanced: Elevate feet or add weight.
        """,
        repetitions: 10
    )
    
    let lunges = Exercise(
        name: "Lunges",
        description: "Step forward and lower body to work legs and glutes.",
        adjustments: """
        Beginner: Reduce depth or hold onto support.
        Advanced: Add weight or increase reps.
        """,
        repetitions: 10
    )
    
    let plank = Exercise(
        name: "Plank",
        description: "Hold a plank position to strengthen core.",
        adjustments: """
        Beginner: Perform on knees.
        Advanced: Extend hold time or add weight.
        """,
        duration: 30
    )
    
    let bicepCurls = Exercise(
        name: "Bicep Curls",
        description: "Curl dumbbells to strengthen biceps.",
        adjustments: """
        Beginner: Use lighter weights.
        Advanced: Increase weight or reps.
        """,
        repetitions: 12,
        weight: 5.0 // Assuming 5 kg as example weight
    )
    
    let tricepDips = Exercise(
        name: "Tricep Dips",
        description: "Use a bench to perform dips targeting triceps.",
        adjustments: """
        Beginner: Bend knees to reduce intensity.
        Advanced: Straighten legs or add weight.
        """,
        repetitions: 10
    )
    
    let deadlifts = Exercise(
        name: "Deadlifts",
        description: "Lift weight from the ground to standing position.",
        adjustments: """
        Beginner: Use lighter weights or perform Romanian deadlifts.
        Advanced: Increase weight or reps.
        """,
        repetitions: 8,
        weight: 20.0 // Assuming 20 kg as example weight
    )
    
    let shoulderPress = Exercise(
        name: "Shoulder Press",
        description: "Press dumbbells overhead to work shoulders.",
        adjustments: """
        Beginner: Use lighter weights or seated position.
        Advanced: Increase weight or perform standing.
        """,
        repetitions: 10,
        weight: 7.5 // Assuming 7.5 kg as example weight
    )
    
    // Cardio Exercises
    
    let jumpingJacks = Exercise(
        name: "Jumping Jacks",
        description: "Jump while spreading legs and arms, then return to starting position.",
        adjustments: """
        Beginner: Step side-to-side instead of jumping.
        Advanced: Increase speed or duration.
        """,
        duration: 60
    )
    
    let highKnees = Exercise(
        name: "High Knees",
        description: "Run in place lifting knees high.",
        adjustments: """
        Beginner: March in place.
        Advanced: Increase speed or duration.
        """,
        duration: 60
    )
    
    let mountainClimbers = Exercise(
        name: "Mountain Climbers",
        description: "Alternate bringing knees to chest in a plank position.",
        adjustments: """
        Beginner: Slow down the pace.
        Advanced: Increase speed or reps.
        """,
        repetitions: 20
    )
    
    let burpees = Exercise(
        name: "Burpees",
        description: "A full-body exercise combining a squat, plank, and jump.",
        adjustments: """
        Beginner: Skip the jump or step back into plank.
        Advanced: Add a push-up or increase speed.
        """,
        repetitions: 10
    )
    
    // Flexibility & Mobility Exercises
    
    let hamstringStretch = Exercise(
        name: "Hamstring Stretch",
        description: "Stretch hamstring muscles by reaching toward toes.",
        adjustments: """
        Beginner: Bend knees slightly.
        Advanced: Reach further or hold longer.
        """,
        duration: 30
    )
    
    let quadStretch = Exercise(
        name: "Quad Stretch",
        description: "Stretch quadriceps by pulling heel toward glutes.",
        adjustments: """
        Beginner: Use support for balance.
        Advanced: Increase hold time or depth.
        """,
        duration: 30
    )
    
    let childPose = Exercise(
        name: "Child's Pose",
        description: "A yoga pose to relax the back and hips.",
        adjustments: """
        Beginner: Use a cushion under hips.
        Advanced: Extend arms further forward.
        """,
        duration: 120
    )
    
    let downwardDog = Exercise(
        name: "Downward Dog",
        description: "An inverted V pose to stretch hamstrings and calves.",
        adjustments: """
        Beginner: Bend knees slightly.
        Advanced: Push heels toward the floor.
        """,
        duration: 60
    )
    
    // Cool-Down Exercises
    
    let slowWalking = Exercise(
        name: "Slow Walking",
        description: "Walk slowly to lower heart rate.",
        adjustments: """
        Beginner: Walk at a comfortable pace.
        Advanced: Focus on deep breathing while walking.
        """,
        duration: 300
    )
    
    let diaphragmaticBreathing = Exercise(
        name: "Diaphragmatic Breathing",
        description: "Deep breathing using the diaphragm.",
        adjustments: """
        Beginner: Focus on comfortable breathing.
        Advanced: Combine with meditation.
        """,
        duration: 300
    )
    
    let seatedForwardFold = Exercise(
        name: "Seated Forward Fold",
        description: "Stretch the back and hamstrings by reaching forward.",
        adjustments: """
        Beginner: Use a strap or bend knees slightly.
        Advanced: Reach further or hold longer.
        """,
        duration: 120
    )
    
    lazy var allExercises = [
        armCircles, legSwings, hipCircles, torsoTwists,
        bodyweightSquats, pushUps, lunges, plank,
        bicepCurls, tricepDips, deadlifts, shoulderPress,
        jumpingJacks, highKnees, mountainClimbers, burpees,
        hamstringStretch, quadStretch, childPose, downwardDog,
        slowWalking, diaphragmaticBreathing, seatedForwardFold
    ]
    
    // MARK: - Workout Modules
    
    // Warm-Up Modules
    
    lazy var dynamicStretchWarmUp = WorkoutModule(
        name: "Dynamic Stretch Warm-Up",
        description: "A sequence of dynamic stretches targeting major muscle groups.",
        category: .warmUp,
        exercises: [armCircles, legSwings, hipCircles, torsoTwists],
        adjustments: """
        Beginner: Perform movements slowly with smaller ranges of motion.
        Advanced: Increase speed and range of motion.
        """
    )
    
    lazy var cardioWarmUp = WorkoutModule(
        name: "Cardio Warm-Up",
        description: "Light cardiovascular exercises to elevate heart rate.",
        category: .warmUp,
        exercises: [jumpingJacks, highKnees],
        adjustments: """
        Beginner: Reduce duration or intensity; step side-to-side instead of jumping.
        Advanced: Increase speed or add resistance.
        """
    )
    
    lazy var yogaFlowWarmUp = WorkoutModule(
        name: "Yoga Flow Warm-Up",
        description: "A gentle flow to awaken the body and mind.",
        category: .warmUp,
        exercises: [downwardDog, childPose],
        adjustments: """
        Beginner: Modify poses using props.
        Advanced: Hold poses longer or deepen stretches.
        """
    )
    
    // Strength Training Modules
    
    lazy var fullBodyFundamentals = WorkoutModule(
        name: "Full-Body Fundamentals",
        description: "Basic exercises targeting all major muscle groups.",
        category: .strengthTraining,
        exercises: [bodyweightSquats, pushUps, lunges, plank],
        adjustments: """
        Beginner: Modify exercises to reduce intensity.
        Advanced: Add weights or increase reps.
        """
    )
    
    lazy var upperBodyBlast = WorkoutModule(
        name: "Upper Body Blast",
        description: "Focus on strengthening the upper body.",
        category: .strengthTraining,
        exercises: [pushUps, bicepCurls, tricepDips, shoulderPress],
        adjustments: """
        Beginner: Use lighter weights or fewer reps.
        Advanced: Increase weight or add sets.
        """
    )
    
    lazy var lowerBodyStrength = WorkoutModule(
        name: "Lower Body Strength",
        description: "Exercises targeting legs and glutes.",
        category: .strengthTraining,
        exercises: [bodyweightSquats, lunges, deadlifts],
        adjustments: """
        Beginner: Use bodyweight or lighter weights.
        Advanced: Increase weight or add plyometric movements.
        """
    )
    
    lazy var coreConditioning = WorkoutModule(
        name: "Core Conditioning",
        description: "Strengthen abdominal and back muscles.",
        category: .strengthTraining,
        exercises: [plank, mountainClimbers],
        adjustments: """
        Beginner: Perform on knees or reduce reps.
        Advanced: Extend hold time or add weight.
        """
    )
    
    // Cardio Modules
    
    lazy var hiitCircuit = WorkoutModule(
        name: "HIIT Circuit",
        description: "High-Intensity Interval Training with bodyweight exercises.",
        category: .cardio,
        exercises: [jumpingJacks, burpees, mountainClimbers],
        adjustments: """
        Beginner: Perform modified versions; increase rest time.
        Advanced: Reduce rest time; increase duration of exercises.
        """
    )
    
    lazy var steadyStateCardio = WorkoutModule(
        name: "Steady-State Cardio",
        description: "Maintain a steady pace to improve endurance.",
        category: .cardio,
        exercises: [slowWalking],
        adjustments: """
        Beginner: Maintain comfortable pace.
        Advanced: Increase speed or incline.
        """
    )
    
    // Flexibility & Mobility Modules
    
    lazy var staticStretchingRoutine = WorkoutModule(
        name: "Static Stretching Routine",
        description: "Hold stretches to improve flexibility.",
        category: .flexibilityAndMobility,
        exercises: [hamstringStretch, quadStretch, seatedForwardFold],
        adjustments: """
        Beginner: Use support as needed.
        Advanced: Increase hold times or deepen stretches.
        """
    )
    
    lazy var yogaFlexFlow = WorkoutModule(
        name: "Yoga Flex Flow",
        description: "A flow of yoga poses for flexibility.",
        category: .flexibilityAndMobility,
        exercises: [downwardDog, childPose, seatedForwardFold],
        adjustments: """
        Beginner: Modify poses with props.
        Advanced: Add challenging poses or hold longer.
        """
    )
    
    // Cool-Down Modules
    
    lazy var guidedBreathing = WorkoutModule(
        name: "Guided Breathing",
        description: "Breathing exercises to promote relaxation.",
        category: .coolDown,
        exercises: [diaphragmaticBreathing],
        adjustments: """
        Adjust counts and focus as needed.
        """
    )
    
    lazy var stretchAndReflect = WorkoutModule(
        name: "Stretch and Reflect",
        description: "Combination of stretching and mindfulness.",
        category: .coolDown,
        exercises: [seatedForwardFold, childPose],
        adjustments: """
        Beginner: Use props for support.
        Advanced: Focus on deeper relaxation techniques.
        """
    )
    
    lazy var allWorkoutModules = [
        // Warm-Ups
        dynamicStretchWarmUp, cardioWarmUp, yogaFlowWarmUp,
        // Strength Training
        fullBodyFundamentals, upperBodyBlast, lowerBodyStrength, coreConditioning,
        // Cardio
        hiitCircuit, steadyStateCardio,
        // Flexibility & Mobility
        staticStretchingRoutine, yogaFlexFlow,
        // Cool-Downs
        guidedBreathing, stretchAndReflect
    ]
    
    
    // MARK: - Training Plan
    
    lazy var totalBodyWorkoutDay = TrainingPlan(
        name: "Total Body Workout Day",
        description: "A full-body workout combining strength, cardio, and flexibility.",
        modules: [
            dynamicStretchWarmUp,
            fullBodyFundamentals,
            hiitCircuit,
            staticStretchingRoutine,
            guidedBreathing
        ]
    )
    
    lazy var upperBodyFocus = TrainingPlan(
        name: "Upper Body Focus",
        description: "A workout targeting upper body strength.",
        modules: [
            cardioWarmUp,
            upperBodyBlast,
            steadyStateCardio,
            yogaFlexFlow,
            stretchAndReflect
        ]
    )
    
    lazy var cardioAndCore = TrainingPlan(
        name: "Cardio and Core",
        description: "A workout focusing on cardiovascular health and core strength.",
        modules: [
            cardioWarmUp,
            hiitCircuit,
            coreConditioning,
            staticStretchingRoutine,
            guidedBreathing
        ]
    )
    
    lazy var lowerBodyStrengthDay = TrainingPlan(
        name: "Lower Body Strength Day",
        description: "Strengthen your legs and glutes.",
        modules: [
            dynamicStretchWarmUp,
            lowerBodyStrength,
            steadyStateCardio,
            yogaFlexFlow,
            guidedBreathing
        ]
    )
    
    lazy var flexibilityAndRecovery = TrainingPlan(
        name: "Flexibility and Recovery",
        description: "Focus on stretching and recovery.",
        modules: [
            yogaFlowWarmUp,
            staticStretchingRoutine,
            yogaFlexFlow,
            stretchAndReflect,
            guidedBreathing
        ]
    )
    
    // Collect all training plans
    
    lazy var allTrainingPlans = [
        totalBodyWorkoutDay,
        upperBodyFocus,
        cardioAndCore,
        lowerBodyStrengthDay,
        flexibilityAndRecovery
    ]
}
