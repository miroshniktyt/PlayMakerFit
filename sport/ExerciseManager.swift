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
        duration: 60
    )
    
    // Add these new yoga exercises
    lazy var catCowPose = Exercise(
        name: "Cat-Cow Pose",
        description: "Alternate arching and rounding your spine",
        adjustments: """
        Beginner: Move slowly and focus on breath
        Advanced: Add more fluid movements
        """,
        duration: 60
    )
    
    lazy var threadTheNeedle = Exercise(
        name: "Thread the Needle",
        description: "Thread one arm under the opposite arm while keeping hips square",
        adjustments: "Keep hips lifted and core engaged",
        duration: 30
    )
    
    lazy var lowLunge = Exercise(
        name: "Low Lunge",
        description: "Stretch hips and thighs",
        adjustments: "Keep back knee lifted for more challenge",
        duration: 30
    )
    
    lazy var mountainPose = Exercise(
        name: "Mountain Pose",
        description: "Standing tall with feet together",
        duration: 15
    )
    
    lazy var forwardFold = Exercise(
        name: "Forward Fold",
        description: "Bend forward from hips",
        duration: 15
    )
    
    lazy var halfwayLift = Exercise(
        name: "Halfway Lift",
        description: "Lift torso parallel to floor",
        duration: 15
    )
    
    lazy var plankPose = Exercise(
        name: "Plank Pose",
        description: "Hold body in straight line",
        duration: 30
    )
    
    lazy var chaturanga = Exercise(
        name: "Chaturanga Dandasana",
        description: "Low Push-Up position",
        duration: 15
    )
    
    lazy var upwardDog = Exercise(
        name: "Upward Dog",
        description: "Push chest forward and up",
        duration: 15
    )
    
    lazy var warriorOne = Exercise(
        name: "Warrior I",
        description: "Lunge with back foot at 45 degrees",
        duration: 30
    )
    
    lazy var warriorTwo = Exercise(
        name: "Warrior II",
        description: "Lunge with back foot at 90 degrees",
        duration: 30
    )
    
    lazy var reverseWarrior = Exercise(
        name: "Reverse Warrior",
        description: "Back bend in Warrior II position",
        duration: 30
    )
    
    lazy var chairPose = Exercise(
        name: "Chair Pose",
        description: "Squat with arms raised",
        duration: 30
    )
    
    lazy var sidePlank = Exercise(
        name: "Side Plank",
        description: "Balance on one arm",
        duration: 15
    )
    
    lazy var crescentLunge = Exercise(
        name: "Crescent Lunge",
        description: "High lunge with back heel lifted",
        duration: 30
    )
    
    lazy var twistedCrescentLunge = Exercise(
        name: "Twisted Crescent Lunge",
        description: "Twist torso in high lunge position",
        duration: 30
    )
    
    lazy var crowPose = Exercise(
        name: "Crow Pose",
        description: "Balance on arms with knees on elbows",
        duration: 15
    )
    
    lazy var bridgePose = Exercise(
        name: "Bridge Pose",
        description: "Lift hips with feet planted",
        duration: 30
    )
    
    lazy var happyBaby = Exercise(
        name: "Happy Baby",
        description: "Hold feet while lying on back",
        duration: 60
    )
    
    lazy var supineTwist = Exercise(
        name: "Supine Twist",
        description: "Twist spine while lying down",
        duration: 30
    )
    
    lazy var savasana = Exercise(
        name: "Savasana",
        description: "Final relaxation pose",
        duration: 120
    )
    
    lazy var easyPoseBreathwork = Exercise(
        name: "Easy Pose with Breathwork",
        description: "Seated cross-legged with focused breathing",
        adjustments: "Keep spine straight and shoulders relaxed",
        duration: 60
    )
    
    lazy var forwardFoldSway = Exercise(
        name: "Forward Fold with Sway",
        description: "Forward fold with gentle side-to-side movement",
        adjustments: "Bend knees if needed",
        duration: 60
    )
    
    lazy var trianglePose = Exercise(
        name: "Triangle Pose",
        description: "Extended side angle with one hand reaching down",
        adjustments: """
        Beginner: Use a block for support
        Advanced: Reach hand to floor
        """,
        duration: 60
    )
    
    lazy var treePose = Exercise(
        name: "Tree Pose",
        description: "Balance on one leg with other foot placed on inner thigh",
        adjustments: """
        Beginner: Foot on calf or use wall for support
        Advanced: Close eyes or add arm variations
        """,
        duration: 30
    )
    
    lazy var butterflyPose = Exercise(
        name: "Butterfly Pose",
        description: "Seated with soles of feet together",
        adjustments: """
        Beginner: Use blocks under knees
        Advanced: Fold forward more deeply
        """,
        duration: 60
    )
    
    lazy var easyPoseNeckStretches = Exercise(
        name: "Easy Pose with Neck Stretches",
        description: "Seated cross-legged with gentle neck movements",
        adjustments: """
        Beginner: Keep movements small and gentle
        Advanced: Add deeper stretches
        """,
        duration: 60
    )
    
    lazy var dragonPose = Exercise(
        name: "Dragon Pose",
        description: "Deep hip flexor stretch in low lunge position",
        adjustments: """
        Beginner: Keep back knee down
        Advanced: Sink deeper into the pose
        """,
        duration: 180  // 3 minutes for Yin style
    )
    
    lazy var halfPigeonPose = Exercise(
        name: "Half Pigeon Pose",
        description: "Deep hip opener with one leg forward",
        adjustments: """
        Beginner: Use props under hip
        Advanced: Fold forward more deeply
        """,
        duration: 180  // 3 minutes for Yin style
    )
    
    // Add new exercises
    lazy var skippingRope = Exercise(
        name: "Skipping Rope",
        description: "Jump rope for cardio warm-up",
        adjustments: """
        Beginner: Start with basic jumps
        Advanced: Add double-unders
        """,
        duration: 120
    )
    
    lazy var shortSprints = Exercise(
        name: "Short Sprints (20m)",
        description: "Explosive sprints for power development",
        adjustments: "Focus on acceleration and form",
        repetitions: 4
    )
    
    lazy var lungesWithTwist = Exercise(
        name: "Lunges with Twist",
        description: "Dynamic lunge with upper body rotation",
        adjustments: "Keep front knee stable during twist",
        duration: 60
    )
    
    lazy var weightedSquats = Exercise(
        name: "Weighted Squats",
        description: "Explosive squats with weights",
        adjustments: """
        Beginner: Start with lighter weights
        Advanced: Increase weight, maintain explosiveness
        """,
        repetitions: 8,
        weight: 60.0
    )
    
    lazy var walkingLunges = Exercise(
        name: "Walking Lunges with Dumbbells",
        description: "Lunges while holding dumbbells",
        adjustments: "Keep torso upright",
        repetitions: 24,  // 12 per leg
        weight: 10.0
    )
    
    lazy var benchPress = Exercise(
        name: "Bench Press",
        description: "Classic chest strengthening exercise",
        adjustments: """
        Beginner: Start with lighter weights
        Advanced: Increase weight with proper form
        """,
        repetitions: 8,
        weight: 40.0
    )
    
    lazy var pullUps = Exercise(
        name: "Pull-Ups",
        description: "Upper body pulling exercise",
        adjustments: """
        Beginner: Use assistance band
        Advanced: Add weight
        """,
        repetitions: 10
    )
    
    lazy var medicineBallSlams = Exercise(
        name: "Medicine Ball Slams",
        description: "Explosive full-body power exercise",
        adjustments: "Focus on explosive movement",
        repetitions: 10,
        weight: 8.0
    )
    
    lazy var foamRolling = Exercise(
        name: "Foam Rolling",
        description: "Self-myofascial release for recovery",
        adjustments: "Adjust pressure as needed",
        duration: 180
    )
    
    lazy var lightJogging = Exercise(
        name: "Light Jogging",
        description: "Easy-paced jogging to warm up",
        adjustments: "Adjust pace as needed",
        duration: 180  // 3 minutes
    )
    
    lazy var ladderDrills = Exercise(
        name: "Ladder Drills",
        description: "Quick footwork through agility ladder",
        adjustments: """
        Beginner: Focus on accuracy
        Advanced: Increase speed
        """,
        duration: 120
    )
    
    lazy var sideLunges = Exercise(
        name: "Side Lunges",
        description: "Lateral lunges for hip mobility",
        adjustments: "Keep chest up, push hips back",
        duration: 60
    )
    
    lazy var quickConeSprints = Exercise(
        name: "Quick Cone Sprints",
        description: "Short explosive sprints between cones",
        repetitions: 5
    )
    
    lazy var sprintInterval = Exercise(
        name: "Sprint",
        description: "High-intensity sprint",
        adjustments: "Maximum effort",
        duration: 30
    )
    
    lazy var jogInterval = Exercise(
        name: "Recovery Jog",
        description: "Light jog for active recovery",
        adjustments: "Keep moving but recover",
        duration: 90
    )
    
    lazy var agilityLadderWork = Exercise(
        name: "Agility Ladder Work",
        description: "Various footwork patterns through ladder",
        adjustments: """
        Beginner: Master basic patterns
        Advanced: Add complex patterns
        """,
        repetitions: 5
    )
    
    lazy var boxJumps = Exercise(
        name: "Box Jumps",
        description: "Explosive jumps onto elevated platform",
        adjustments: "Focus on soft landings",
        repetitions: 12
    )
    
    lazy var singleLegSquats = Exercise(
        name: "Single-Leg Squats",
        description: "Balance squats on one leg",
        adjustments: "Use support if needed",
        repetitions: 8
    )
    
    lazy var bosuBallLunges = Exercise(
        name: "Bosu Ball Lunges",
        description: "Lunges with front foot on Bosu ball",
        adjustments: "Focus on stability",
        repetitions: 8
    )
    
    lazy var plankToPushUp = Exercise(
        name: "Plank to Push-Up",
        description: "Alternate between plank and push-up position",
        repetitions: 12
    )
    
    lazy var gentleJogging = Exercise(
        name: "Gentle Jogging",
        description: "Very light jogging to cool down",
        duration: 120
    )
    
    // Add new basketball exercises
    lazy var depthJumps = Exercise(
        name: "Depth Jumps",
        description: "Step off a box, jump explosively upon landing",
        adjustments: """
        Beginner: Use lower box height
        Advanced: Increase box height
        """,
        repetitions: 8
    )
    
    lazy var broadJumps = Exercise(
        name: "Broad Jumps",
        description: "Jump forward as far as possible, landing softly",
        adjustments: "Focus on soft landing",
        repetitions: 10
    )
    
    lazy var squatJumps = Exercise(
        name: "Squat Jumps",
        description: "Explosive jumps from squat position",
        adjustments: "Add weight for difficulty",
        repetitions: 10
    )
    
    lazy var barbellBackSquats = Exercise(
        name: "Barbell Back Squats",
        description: "Traditional weighted back squats",
        adjustments: "Maintain proper form",
        repetitions: 8,
        weight: 60.0
    )
    
    lazy var overheadPress = Exercise(
        name: "Overhead Press",
        description: "Press weight overhead for shoulder strength",
        adjustments: "Keep core tight",
        repetitions: 10,
        weight: 20.0
    )
    
    lazy var bulgarianSplitSquats = Exercise(
        name: "Bulgarian Split Squats",
        description: "Single-leg squats with rear foot elevated",
        adjustments: "Keep front knee stable",
        repetitions: 10,
        weight: 15.0
    )
    
    lazy var suicideRuns = Exercise(
        name: "Suicide Runs",
        description: "Progressive sprints to different court markers",
        adjustments: "Maintain speed throughout",
        repetitions: 5
    )
    
    lazy var farmersWalks = Exercise(
        name: "Farmer's Walks",
        description: "Carry heavy weights while walking",
        adjustments: "Keep shoulders back",
        repetitions: 3,
        weight: 25.0
    )
    
    lazy var coneDrills = Exercise(
        name: "Cone Drills",
        description: "Sprint, shuffle, and backpedal between cones",
        adjustments: "Stay low during transitions",
        repetitions: 5
    )
    
    lazy var reactionDrills = Exercise(
        name: "Reaction Drills",
        description: "Quick direction changes based on signals",
        adjustments: "Stay on balls of feet",
        repetitions: 5
    )
    
    lazy var lateralBounds = Exercise(
        name: "Lateral Bounds",
        description: "Explosive sideways jumps",
        adjustments: "Land softly and controlled",
        repetitions: 12
    )
    
    lazy var allExercises = [
        armCircles, legSwings, hipCircles, torsoTwists,
        bodyweightSquats, pushUps, lunges, plank,
        bicepCurls, tricepDips, deadlifts, shoulderPress,
        jumpingJacks, highKnees, mountainClimbers, burpees,
        hamstringStretch, quadStretch, childPose, downwardDog,
        slowWalking, diaphragmaticBreathing, seatedForwardFold,
        catCowPose, threadTheNeedle, lowLunge, mountainPose,
        forwardFold, halfwayLift, plankPose, chaturanga,
        upwardDog, warriorOne, warriorTwo, reverseWarrior,
        chairPose, sidePlank, crescentLunge, twistedCrescentLunge,
        crowPose, seatedForwardFold, bridgePose, happyBaby,
        supineTwist, savasana,
        easyPoseBreathwork, forwardFoldSway, trianglePose, 
        treePose, butterflyPose,
        easyPoseNeckStretches, dragonPose, halfPigeonPose,
        skippingRope, shortSprints, lungesWithTwist,
        weightedSquats, walkingLunges, benchPress,
        pullUps, medicineBallSlams, foamRolling,
        lightJogging, ladderDrills, sideLunges, quickConeSprints,
        sprintInterval, jogInterval, agilityLadderWork, boxJumps,
        singleLegSquats, bosuBallLunges, plankToPushUp, gentleJogging,
        depthJumps, broadJumps, squatJumps,
        barbellBackSquats, overheadPress, bulgarianSplitSquats,
        suicideRuns, farmersWalks, coneDrills,
        reactionDrills, lateralBounds
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
    
    // Add new workout modules
    lazy var yogaWarmUp = WorkoutModule(
        name: "Yoga Warm-Up",
        description: "Gentle poses to warm up the body",
        category: .warmUp,
        exercises: [childPose, catCowPose, threadTheNeedle, downwardDog, lowLunge]
    )
    
    lazy var yogaFlow1 = WorkoutModule(
        name: "Sun Salutation Flow",
        description: "Classic yoga flow sequence",
        category: .flexibilityAndMobility,
        exercises: [
            mountainPose, forwardFold, halfwayLift, plankPose,
            chaturanga, upwardDog, downwardDog,
            warriorOne, warriorTwo, reverseWarrior
        ]
    )
    
    lazy var yogaFlow2 = WorkoutModule(
        name: "Power Flow",
        description: "More challenging yoga sequence",
        category: .flexibilityAndMobility,
        exercises: [
            chairPose, forwardFold, plankPose, sidePlank,
            chaturanga, upwardDog, downwardDog,
            crescentLunge, twistedCrescentLunge, crowPose
        ]
    )
    
    lazy var yogaCoolDown = WorkoutModule(
        name: "Yoga Cool-Down",
        description: "Gentle stretches to end practice",
        category: .coolDown,
        exercises: [
            seatedForwardFold, bridgePose, happyBaby,
            supineTwist, savasana
        ]
    )
    
    lazy var hathaWarmUp = WorkoutModule(
        name: "Hatha Warm-Up",
        description: "Gentle warm-up sequence for Hatha yoga",
        category: .warmUp,
        exercises: [
            easyPoseBreathwork,
            catCowPose,
            forwardFoldSway,
            lowLunge
        ]
    )
    
    lazy var hathaMainSequence = WorkoutModule(
        name: "Hatha Main Sequence",
        description: "Core poses of Hatha practice",
        category: .flexibilityAndMobility,
        exercises: [
            mountainPose,
            warriorOne,
            warriorTwo,
            trianglePose,
            treePose,
            bridgePose,
            supineTwist
        ]
    )
    
    lazy var hathaCoolDown = WorkoutModule(
        name: "Hatha Cool-Down",
        description: "Gentle cool-down sequence",
        category: .coolDown,
        exercises: [
            seatedForwardFold,
            butterflyPose,
            savasana
        ]
    )
    
    // Add new workout modules for Yin Yoga
    lazy var yinWarmUp = WorkoutModule(
        name: "Yin Warm-Up",
        description: "Gentle preparation for deep stretches",
        category: .warmUp,
        exercises: [
            easyPoseNeckStretches,
            catCowPose,
            childPose,
            downwardDog
        ]
    )
    
    lazy var yinMainSequence = WorkoutModule(
        name: "Yin Main Sequence",
        description: "Deep, long-held stretches",
        category: .flexibilityAndMobility,
        exercises: [
            butterflyPose,
            dragonPose,
            halfPigeonPose,
            supineTwist
        ]
    )
    
    lazy var yinCoolDown = WorkoutModule(
        name: "Yin Cool-Down",
        description: "Gentle closing sequence",
        category: .coolDown,
        exercises: [
            seatedForwardFold,
            savasana
        ]
    )
    
    // Add new workout modules
    lazy var footballWarmUp = WorkoutModule(
        name: "Football Power Warm-Up",
        description: "Dynamic warm-up for explosive movements",
        category: .warmUp,
        exercises: [
            highKnees,
            legSwings,
            armCircles,
            skippingRope,
            bodyweightSquats,
            lungesWithTwist,
            shortSprints
        ]
    )
    
    lazy var footballMainRoutine = WorkoutModule(
        name: "Football Strength Training",
        description: "Power and strength development for football",
        category: .strengthTraining,
        exercises: [
            weightedSquats,
            deadlifts,
            walkingLunges,
            benchPress,
            pullUps,
            medicineBallSlams
        ]
    )
    
    lazy var footballCoolDown = WorkoutModule(
        name: "Football Recovery",
        description: "Recovery and flexibility work",
        category: .coolDown,
        exercises: [
            foamRolling,
            hamstringStretch,
            quadStretch
        ]
    )
    
    // Add the new training plan
    lazy var footballLegsAndPower = TrainingPlan(
        name: "Football Legs & Power",
        description: "Develop explosive power for tackles, jumps, and sprints. Focus on leg strength and overall power development.",
        trainingPlanCategory: .football,
        modules: [
            footballWarmUp,
            footballMainRoutine,
            footballCoolDown
        ]
    )
    
    // Create HIIT module with alternating sprints and jogs
    lazy var hiitSprints = WorkoutModule(
        name: "HIIT Sprint Intervals",
        description: "8 rounds of sprint/jog intervals",
        category: .cardio,
        exercises: Array(repeating: [sprintInterval, jogInterval], count: 8).flatMap { $0 }
    )
    
    // Add new workout modules
    lazy var footballCardioWarmUp = WorkoutModule(
        name: "Football Cardio Warm-Up",
        description: "Dynamic warm-up for cardio training",
        category: .warmUp,
        exercises: [
            lightJogging,
            ladderDrills,
            sideLunges,
            armCircles,
            quickConeSprints
        ]
    )
    
    lazy var footballCardioMain = WorkoutModule(
        name: "Football Cardio & Coordination",
        description: "Main cardio and agility work",
        category: .cardio,
        exercises: [
            agilityLadderWork,
            boxJumps,
            singleLegSquats,
            bosuBallLunges,
            plankToPushUp
        ]
    )
    
    lazy var footballCardioCoolDown = WorkoutModule(
        name: "Football Cardio Cool-Down",
        description: "Light cool-down and stretching",
        category: .coolDown,
        exercises: [
            gentleJogging,
            hamstringStretch,
            childPose
        ]
    )
    
    // Add the new training plan
    lazy var footballCardio = TrainingPlan(
        name: "Football Cardio & Coordination",
        description: "Boost stamina and refine balance, coordination, and quick reactions.",
        trainingPlanCategory: .football,
        modules: [
            footballCardioWarmUp,
            hiitSprints,
            footballCardioMain,
            footballCardioCoolDown
        ]
    )
    
    // Add new workout modules
    lazy var basketballJumpTraining = WorkoutModule(
        name: "Vertical Jump Training",
        description: "Explosive jump training for basketball",
        category: .strengthTraining,
        exercises: [
            depthJumps,
            broadJumps,
            squatJumps
        ]
    )
    
    lazy var basketballStrengthTraining = WorkoutModule(
        name: "Basketball Strength",
        description: "Strength training for basketball performance",
        category: .strengthTraining,
        exercises: [
            barbellBackSquats,
            overheadPress,
            bulgarianSplitSquats
        ]
    )
    
    lazy var basketballConditioning = WorkoutModule(
        name: "Basketball Conditioning",
        description: "Endurance training for basketball",
        category: .cardio,
        exercises: [
            suicideRuns,
            farmersWalks
        ]
    )
    
    lazy var basketballAgility = WorkoutModule(
        name: "Basketball Agility",
        description: "Agility and reaction training",
        category: .cardio,
        exercises: [
            coneDrills,
            reactionDrills,
            lateralBounds
        ]
    )
    
    // Add the new training plans
    lazy var basketballStrength = TrainingPlan(
        name: "Basketball Explosive Strength",
        description: "Focus on explosive jumps, strength, and endurance",
        trainingPlanCategory: .basketBall,
        modules: [
            dynamicStretchWarmUp,
            basketballJumpTraining,
            basketballStrengthTraining,
            basketballConditioning,
            stretchAndReflect
        ]
    )
    
    lazy var basketballAgilityPlan = TrainingPlan(
        name: "Basketball Agility & Speed",
        description: "Focus on agility, coordination, and endurance",
        trainingPlanCategory: .basketBall,
        modules: [
            dynamicStretchWarmUp,
            basketballJumpTraining,
            basketballAgility,
            basketballConditioning,
            stretchAndReflect
        ]
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
        guidedBreathing, stretchAndReflect,
        // Yoga
        yogaWarmUp, yogaFlow1, yogaFlow2, yogaCoolDown,
        hathaWarmUp, hathaMainSequence, hathaCoolDown,
        // Yin Yoga
        yinWarmUp, yinMainSequence, yinCoolDown,
        // Football
        footballWarmUp, footballMainRoutine, footballCoolDown,
        footballCardioWarmUp, hiitSprints, footballCardioMain, footballCardioCoolDown,
        basketballJumpTraining, basketballStrengthTraining,
        basketballConditioning, basketballAgility
    ]
    
    
    // MARK: - Training Plan
    
    lazy var totalBodyWorkoutDay = TrainingPlan(
        name: "Total Body Workout Day",
        description: "A full-body workout combining strength, cardio, and flexibility.",
        trainingPlanCategory: .gym,
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
        trainingPlanCategory: .gym,
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
        trainingPlanCategory: .generalFitness,
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
        trainingPlanCategory: .gym,
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
        trainingPlanCategory: .generalFitness,
        modules: [
            yogaFlowWarmUp,
            staticStretchingRoutine,
            yogaFlexFlow,
            stretchAndReflect,
            guidedBreathing
        ]
    )
    
    // Add the new training plan
    lazy var vinyasaYogaFlow = TrainingPlan(
        name: "30-Minute Vinyasa Flow",
        description: "A balanced yoga practice combining flowing movements with strength and flexibility",
        trainingPlanCategory: .yoga,
        modules: [
            yogaWarmUp,
            yogaFlow1,
            yogaFlow2,
            yogaCoolDown
        ]
    )
    
    // Add the new training plan
    lazy var hathaYoga = TrainingPlan(
        name: "30-Minute Hatha Yoga",
        description: "A gentle, traditional Hatha yoga practice focusing on proper alignment and breath",
        trainingPlanCategory: .yoga,
        modules: [
            hathaWarmUp,
            hathaMainSequence,
            hathaCoolDown
        ]
    )
    
    // Add the new training plan
    lazy var yinYoga = TrainingPlan(
        name: "30-Minute Yin Yoga",
        description: "A meditative, slower style focusing on deep stretches held for extended periods. Great for improving flexibility and calming the mind.",
        trainingPlanCategory: .yoga,
        modules: [
            yinWarmUp,
            yinMainSequence,
            yinCoolDown
        ]
    )
    
    // Collect all training plans
    
    lazy var allTrainingPlans = [
        totalBodyWorkoutDay,
        upperBodyFocus,
        cardioAndCore,
        lowerBodyStrengthDay,
        flexibilityAndRecovery,
        vinyasaYogaFlow,
        hathaYoga,
        yinYoga,
        footballLegsAndPower,
        footballCardio,
        basketballStrength,
        basketballAgilityPlan
    ]
}
